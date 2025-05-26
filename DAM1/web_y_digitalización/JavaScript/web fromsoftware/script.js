document.addEventListener("DOMContentLoaded", () => {
    //  Modo claro/oscuro
    const toggle = document.getElementById("theme-toggle");
    const body = document.body;
    const savedTheme = localStorage.getItem("theme");
  
    if (savedTheme === "dark") {
      body.classList.add("dark");
      toggle.textContent = "☀️";
    } else {
      toggle.textContent = "🌙";
    }
  
    toggle.addEventListener("click", () => {
      body.classList.toggle("dark");
      const isDark = body.classList.contains("dark");
      toggle.textContent = isDark ? "☀️" : "🌙";
      localStorage.setItem("theme", isDark ? "dark" : "light");
    });
  
    //  Cookies
    const cookieModal = document.querySelector(".cookie-consent-modal");
    const rechazarCookieButton = document.querySelector(".btn.rechazar");
    const aceptarCookieButton = document.querySelector(".btn.aceptar");
    const cookieMessage = document.querySelector(".msg-principal");
    const cookieMessage2 = document.querySelector(".msg-secundario");
  
    rechazarCookieButton.addEventListener("click", () => {
      cookieMessage.classList.add("active");
      cookieMessage2.classList.add("active");
    });
  
    aceptarCookieButton.addEventListener("click", () => {
      cookieModal.classList.remove("active");
      localStorage.setItem("cookiesAccepted", "true");
    });
  
    setTimeout(() => {
      const cookieAccepted = localStorage.getItem("cookiesAccepted");
      if (cookieAccepted !== "true") {
        cookieModal.classList.add("active");
        cookieMessage.classList.remove("active");
        cookieMessage2.classList.remove("active");
      }
    }, 2000);
  
    function enableTapCaptionsOnSmallScreens() {
      const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
      const isSmallScreen = window.innerWidth <= 768;
  
      if (isTouchDevice && isSmallScreen) {
        const heroItems = document.querySelectorAll('.hero-item');
  
        heroItems.forEach(item => {
          const caption = item.querySelector('.hero-caption');
  
          item.addEventListener('click', () => {
            const isVisible = caption.style.opacity === '1';
            document.querySelectorAll('.hero-caption').forEach(c => c.style.opacity = '0');
            if (!isVisible) caption.style.opacity = '1';
          });
        });
      }
    }
  
    enableTapCaptionsOnSmallScreens();
  
    //  Menú hamburguesa
    const hamMenu = document.querySelector('.ham-menu');
    const offScreenMenu = document.querySelector('.off-screen-menu');
  
    hamMenu.addEventListener('click', () => {
      hamMenu.classList.toggle('active');
      offScreenMenu.classList.toggle('active');
    });
  
    document.querySelectorAll('.off-screen-menu a').forEach(link => {
      link.addEventListener('click', () => {
        hamMenu.classList.remove('active');
        offScreenMenu.classList.remove('active');
      });
    });
  
    //  Login: mostrar modal
    const loginBtn = document.querySelector(".login-btn");
    const loginModal = document.getElementById("login-modal");
    const closeLogin = document.getElementById("close-login");
  
    if (loginBtn) {
      loginBtn.addEventListener("click", () => {
        loginModal.classList.remove("hidden");
      });
    }
  
    if (closeLogin) {
      closeLogin.addEventListener("click", () => {
        loginModal.classList.add("hidden");
      });
    }
  
    // Validación de login + cargar usuarios de API
    const loginForm = document.getElementById('login-form');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const loginError = document.getElementById('login-error');
  
    if (loginForm) {
      loginForm.addEventListener('submit', (e) => {
        e.preventDefault();
  
        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();
  
        const isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        const isPasswordValid = /^(?=.*[A-Z])(?=.*\d).{8,}$/.test(password);
  
        if (!isEmailValid) {
          loginError.textContent = "Correo inválido.";
          return;
        }
  
        if (!isPasswordValid) {
          loginError.textContent = "Contraseña: mínimo 8 caracteres, una mayúscula y un número.";
          return;
        }
  
        loginError.textContent = "";
  
        if (email === "test@from.com" && password === "FromSoft1") {
          loginModal.classList.add("hidden");
  
          if (document.querySelector(".api-users")) return;
  
          fetch('https://jsonplaceholder.typicode.com/users')
            .then(res => res.json())
            .then(users => {
              const section = document.createElement('section');
              section.className = 'api-users';
              section.innerHTML = `<h2>Usuarios desde la API</h2><ul></ul>`;
  
              users.forEach(user => {
                const li = document.createElement('li');
                li.textContent = `${user.name} - ${user.email}`;
                section.querySelector('ul').appendChild(li);
              });
  
              const footer = document.querySelector("footer");
              document.body.insertBefore(section, footer);

            })
            .catch(err => {
              console.error("Error cargando usuarios:", err);
              alert("Hubo un error al cargar los usuarios.");
            });
  
        } else {
          loginError.textContent = "Usuario o contraseña incorrectos.";
        }
      });
    }
  
    // Para que el modo claro/oscuro cambie sin tener que recargar
    window.addEventListener('resize', () => {
      // Puedes comentar esto si prefieres que no recargue:
      location.reload();
    });
  });
  