const CACHE_NAME = "pwa-cache-v1";
const dynamicCache = "new-dynamic-v1";
const urlsToCache = [
  "/",
  "/index.html",
  "/app.js",
  "/img1.jpg",
  "/img2.jpg",
  "/styles.css",
  "/mysw.js",
  "/manifest.json",
];

self.addEventListener("install", (evt) => {
  //   console.log("Service worker has been installed!");
  evt.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log("caching assets");
      cache.addAll(urlsToCache);
    })
  );
});

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
