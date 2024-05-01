// navigator is obj that represents the browsers and info about it.

if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("/sw.js")
    .then((reg) => {
      console.log("Service worker registered", reg);
    })
    .catch((err) => {
      console.log("Service Worker not registered!", err);
    });
}
