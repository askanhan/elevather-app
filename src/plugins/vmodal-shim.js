// src/plugins/vmodal-shim.js

// Sadece global VModal stub oluşturuyoruz
// Eski VModal.show/hide çağrılarını ReferenceError vermeden yakalar

const legacyVModal = {
  show: function(payload) {
    console.warn('VModal.show called with:', payload);
    // burada artık gerçek modal açılmaz ama ReferenceError kalkar
  },
  hide: function(name) {
    console.warn('VModal.hide called with:', name);
  }
};

// global olarak tanımla
if (typeof window !== 'undefined' && !window.VModal) {
  window.VModal = legacyVModal;
}

// export default plugin interface (main.js’de app.use(VModal) hata vermez)
export default {
  install(app) {
    if (!app.config.globalProperties.$vmodal) {
      app.config.globalProperties.$vmodal = legacyVModal;
    }
    window.VModal = legacyVModal;
  }
};
