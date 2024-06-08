// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});


// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker")
  
  //。デフォルトを大阪城に　数値が小さいほうがロング 一回のクリック分
  // クラウドカスタマイズ機能を使用する
  map = new Map(document.getElementById("map"), {
    center: { lat: 34.687295, lng: 135.525809 },
    zoom: 14,
    mapId: "12e54403ce86cc3",
    mapTypeControl: false,

  });
  
  try {
    const response = await fetch("/post_events.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { items } } = await response.json();
    if (!Array.isArray(items)) throw new Error("Items is not an array");

    items.forEach( item => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const shopName = item.title;

      const userImage = item.user.image;
      const userName = item.user.name;
      const postImage = item.image;
      const address = item.address;
      const caption = item.caption;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: shopName,
        // 他の任意のオプションもここに追加可能
      });
      
      const beachFlagImg = document.createElement("img");
      beachFlagImg.src =
        "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png";
        
      const beachFlagMarkerView = new AdvancedMarkerElement({
        map,
        position: { lat: 34.687295, lng: 135.525809 },
        content: beachFlagImg,
        title: "Osaka Catsle",
      });
      
      const contentString = `
        <div class="information container p-0">
          <div class="mb-3">
            <img class="thumbnail" src="${postImage}" width="220" loading="lazy">
          </div>
          <div>
            <h1 class="h5 font-weight-bold">${shopName}</h1>
            <p class="text-muted">${address}</p>
          </div>
          <div class="mb-3 d-flex align-items-center">
            <img class="rounded-circle mr-2" src="${userImage}" width="40" height="40">
            <p class="lead m-0 font-weight-bold">${userName}</p>
          </div>
          <div>
            <p>${caption}</p>
          </div>
        </div>
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        maxWidth: 250,
        ariaLabel: shopName,
        // マウスオーバーの表示
      });

      marker.addListener("click", () => {
        infowindow.open({
        anchor: marker,
        map,
        })
      });
      
      google.maps.event.addListener(map,"click", () => {
        infowindow.close();
      });

    });
  } catch (error) {
    console.error('Error fetching or processing post events:', error);
  }
}
initMap()
