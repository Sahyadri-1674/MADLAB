if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("./mysw.js")
    .then((reg) => {
      console.log("ServiceWorker registered successfully", reg);
    })
    .catch((err) => {
      console.log("ServiceWorker registeration failed ", err);
    });
}
