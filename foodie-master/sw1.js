// Service worker file: service-worker.js

// Define the cache name and the files to cache
const CACHE_NAME = "v1";
const urlsToCache = [
  "/",
  "/index.html",
  "/favicon.svg",
  "/manifest.json",
  "/assets/css/style.css",
  "/assets/js/script.js",
  "/assets/images/about-banner.png",
  "/assets/images/avatar-1.jpg",
  "/assets/images/avatar-2.jpg",
  "/assets/images/avatar-3.jpg",
  "/assets/images/banner-1.jpg",
  "/assets/images/banner-2.jpg",
  "/assets/images/banner-3.jpg",
  "/assets/images/banner-4.jpg",
  "/assets/images/blog-1.jpg",
  "/assets/images/blog-2.jpg",
  "/assets/images/blog-3.jpg",
  "/assets/images/close.png",
  "/assets/images/cta-banner.png",
  "/assets/images/delivery-banner-bg.png",
  "/assets/images/delivery-boy.svg",
  "/assets/images/food-menu-1.png",
  "/assets/images/food-menu-2.png",
  "/assets/images/food-menu-3.png",
  "/assets/images/food-menu-4.png",
  "/assets/images/food-menu-5.png",
  "/assets/images/food-menu-6.png",
  "/assets/images/footer-illustration.png",
  "/assets/images/hero-banner-bg.png",
  "/assets/images/hero-banner.png",
  "/assets/images/hero-bg-shape.png",
  "/assets/images/hero-bg.jpg",
  "/assets/images/promo-1.png",
  "/assets/images/promo-2.png",
  "/assets/images/promo-3.png",
  "/assets/images/promo-4.png",
  "/assets/images/promo-5.png",
  "/assets/images/promo-icon-1.svg",
  "/assets/images/promo-icon-2.svg",
  "/assets/images/promo-icon-3.svg",
  "/assets/images/promo-icon-4.svg",
  "/assets/images/promo-icon-5.svg",
  "/assets/images/sale-shape-red.png",
  "/assets/images/sale-shape.png",
  "/assets/images/shape-grey.png",
  "/assets/images/shape-white.png",
  "/icons/icon-192x192.png",
  "/icons/icon-256x256.png",
  "/icons/icon-384x384.png",
  "/icons/icon-512x512.png",
  "/readme-images/desktop.png",
  // "/index.txt",
  "/style-guide.md"
];

// Install the service worker
self.addEventListener("install", (event) => {
  console.log("install")
  event.waitUntil(
    (async () => {
      const cache = await caches.open(CACHE_NAME);
      console.log("[Service Worker] Caching all: app shell and content");
      await cache.addAll(urlsToCache);
    })(),
  );
});

const cacheMatch = async (request) => {
  const cachedResponse =await caches.match(request)
  if(cachedResponse) return cachedResponse
  try {
    const networkResponse = await fetch(request)
    const cache = await caches.open(CACHE_NAME)
    await cache.put(request,networkResponse.clone())
    return networkResponse
  }
  catch(err){
    return new Response("Response not found!")
  }
}

self.addEventListener("fetch",(event)=> {
  event.respondWith(cacheMatch(event.request))
})

// // Serve cached resources when offline
// self.addEventListener("fetch", (event) => {
//   event.respondWith(
//     caches
//       .match(event.request)
//       .then((response) => {
//         // Cache hit - return response
//         if (response) {
//           return response;
//         }

//         // Not found in cache - fetch and cache
//         return fetch(event.request).then((response) => {
//           // Check if we received a valid response
//           if (
//             !response ||
//             response.status !== 200 ||
//             response.type !== "basic"
//           ) {
//             return response;
//           }

//           // Clone the response since it's a stream and can only be consumed once
//           const responseToCache = response.clone();

//           caches.open(CACHE_NAME).then((cache) => {
//             cache.put(event.request, responseToCache);
//           });

//           return response;
//         });
//       })
//       .catch((error) => {
//         // If fetch fails, return a fallback response
//         console.error("Error fetching and caching:", error);
//         return new Response("Sorry, the page is not available offline.");
//       })
//   );
// });

// // Remove outdated caches
// self.addEventListener("activate", (event) => {
//   const cacheWhitelist = [CACHE_NAME];

//   event.waitUntil(
//     caches.keys().then((cacheNames) => {
//       return Promise.all(
//         cacheNames.map((cacheName) => {
//           if (!cacheWhitelist.includes(cacheName)) {
//             return caches.delete(cacheName);
//           }
//         })
//       );
//     })
//   );
// });
