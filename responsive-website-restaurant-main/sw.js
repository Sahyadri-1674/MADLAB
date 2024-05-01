const CACHE_NAME = "pwa-cache";
const dynamicCache = "site-dynamic-v1";

const urlsToCache = [
  "/",
  "/index.html",
  "/assets/js/app.js",
  "/assets/js/main.js",
  "/assets/css/styles.css",
  "/assets/scss/styles.scss",
  "/assets/img/about.jpg",
  "/assets/img/app1.png",
  "/assets/img/app2.png",
  "/assets/img/dish.svg",
  "/assets/img/home.png",
  "/assets/img/movil-app.png",
  "/assets/img/truck.svg",
  "/assets/img/pizza.svg",
  "/assets/img/plate1.png",
  "/assets/img/plate2.png",
  "/assets/img/plate3.png",
];
// install service worker

self.addEventListener("install", (evt) => {
  //   console.log("Service worker has been installed!");
  evt.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log("caching assets");
      cache.addAll(urlsToCache);
    })
  );
});

//activate service worker

self.addEventListener("activate", (evt) => {
  //   console.log("Service worker has been activated");
  evt.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys
          .filter((key) => key !== staticCacheName)
          .map((key) => caches.delete(key))
      );
    })
  );
});

//fetch event
self.addEventListener("fetch", (evt) => {
  //   console.log("fetch event", evt);
  evt.respondWith(
    caches.match(evt.request).then((cacheRes) => {
      if (cacheRes) return cacheRes;
      else
        return fetch(evt.request).then((fetchRes) => {
          return caches.open(dynamicCache).then((cache) => {
            cache.put(evt.request.url, fetchRes.clone());
            return fetchRes;
          });
        });
    })
  );
});
