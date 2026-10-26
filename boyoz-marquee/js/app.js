(() => {
  "use strict";

  const STORAGE = {
    settings: "boyoz-marquee-settings-v4",
    font: "boyoz-marquee-font-v1",
    theme: "boyoz-marquee-theme-v1",
    customTheme: "boyoz-marquee-custom-theme-v1"
  };

  const DEFAULTS = {
    text: "BoyOz",
    font: "Space Grotesk",
    fontSize: 160,
    speed: 20,
    rotation: -2,
    gap: 96,
    shadow: 8,
    rows: 1,
    rowDirection: "alternate",
    theme: "elegant",
    customTheme: null,
  };

  const THEMES = {
    elegant:{bgA:"#080808",bgB:"#211d19",text:"#f5f1e8",accent:"#d7b77c",shadow:"#070707",shadowOpacity:".88",glow:"rgba(215,183,124,.16)"},
    ocean:{bgA:"#031017",bgB:"#0d3541",text:"#e7fbff",accent:"#64d9eb",shadow:"#031116",shadowOpacity:".90",glow:"rgba(100,217,235,.20)"},
    forest:{bgA:"#040b06",bgB:"#16351f",text:"#edf8ee",accent:"#8bd29b",shadow:"#040b06",shadowOpacity:".90",glow:"rgba(139,210,155,.18)"},
    sunset:{bgA:"#170706",bgB:"#431d13",text:"#fff0e8",accent:"#ff9e72",shadow:"#110504",shadowOpacity:".90",glow:"rgba(255,158,114,.20)"},
    violet:{bgA:"#09050f",bgB:"#26113c",text:"#f7edff",accent:"#c88aff",shadow:"#0a050e",shadowOpacity:".92",glow:"rgba(200,138,255,.20)"},
    ice:{bgA:"#cfe8f5",bgB:"#f3fbff",text:"#10232d",accent:"#338cae",shadow:"#9fc3d2",shadowOpacity:".34",glow:"rgba(255,255,255,.62)"},
    cream:{bgA:"#eadcc1",bgB:"#fff9ec",text:"#33281d",accent:"#a66f2d",shadow:"#c5af86",shadowOpacity:".34",glow:"rgba(255,255,255,.62)"},
    candy:{bgA:"#f2c9df",bgB:"#fff1f7",text:"#44233a",accent:"#c54c8c",shadow:"#d5a1bf",shadowOpacity:".32",glow:"rgba(255,255,255,.64)"},
    lavender:{bgA:"#ded5f4",bgB:"#faf7ff",text:"#302747",accent:"#795fc7",shadow:"#baaee0",shadowOpacity:".30",glow:"rgba(255,255,255,.64)"},
    mint:{bgA:"#cce9dd",bgB:"#f2fff8",text:"#17352a",accent:"#318c6b",shadow:"#a5ccb8",shadowOpacity:".32",glow:"rgba(255,255,255,.64)"}
  };

  const FONT_NAMES = [
    "Space Grotesk","Manrope","Plus Jakarta Sans","DM Sans","Inter",
    "Poppins","Montserrat","Outfit","Sora","Urbanist","Nunito Sans",
    "Raleway","Roboto","Bebas Neue","Archivo Black","Anton","Oswald",
    "League Spartan","Syne","Unbounded","Bungee","Righteous",
    "Abril Fatface","Playfair Display","DM Serif Display",
    "Libre Baskerville","Cormorant Garamond"
  ];

  const $ = (selector, root = document) => root.querySelector(selector);
  const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];
  const root = document.documentElement;

  const els = {
    scene: $("#scene"),
    marquee: $("#marquee"),
    marqueeRows: $("#marqueeRows"),
    textInput: $("#textInput"),
    fontPicker: $("#fontPicker"),
    fontSize: $("#fontSize"),
    speed: $("#speed"),
    rotation: $("#rotation"),
    gap: $("#gap"),
    shadow: $("#shadow"),
    rows: $("#rows"),
    rowDirection: $("#rowDirection"),
    themePicker: $("#themePicker"),
    customTheme: $("#customTheme"),
    applyCustomTheme: $("#applyCustomTheme"),
    colorBgA: $("#colorBgA"),
    colorBgB: $("#colorBgB"),
    colorText: $("#colorText"),
    colorAccent: $("#colorAccent"),
    colorShadow: $("#colorShadow"),
    colorGlow: $("#colorGlow"),
    glowOpacity: $("#glowOpacity"),
    randomTheme: $("#randomTheme"),
    randomBackground: $("#randomBackground"),
    reset: $("#reset"),
    settingsToggle: $("#settingsToggle"),
    settingsPanel: $("#settingsPanel"),
    settingsOverlay: $("#settingsOverlay"),
    themeFlash: $("#themeFlash"),
    googleFontStylesheet: $("#googleFontStylesheet")
  };

  let state = {...DEFAULTS};

  function clamp(value, min, max) {
    return Math.min(max, Math.max(min, value));
  }

  function clampNumber(value, min, max, fallback) {
    const number = Number(value);
    return Number.isFinite(number)
      ? clamp(number, min, max)
      : fallback;
  }

  function readJSON(key, fallback) {
    try {
      const value = localStorage.getItem(key);
      return value ? JSON.parse(value) : fallback;
    } catch {
      return fallback;
    }
  }

  function saveState() {
    try {
      localStorage.setItem(STORAGE.settings, JSON.stringify({
        text: state.text,
        fontSize: state.fontSize,
        speed: state.speed,
        rotation: state.rotation,
        gap: state.gap,
        shadow: state.shadow,
        rows: state.rows,
        rowDirection: state.rowDirection
      }));
      localStorage.setItem(STORAGE.font, state.font);
      localStorage.setItem(STORAGE.theme, state.theme);
      if (state.customTheme) {
        localStorage.setItem(STORAGE.customTheme, JSON.stringify(state.customTheme));
      }
    } catch {}
  }

  function loadState() {
    const settings = readJSON(STORAGE.settings,{});

    state = {
      ...DEFAULTS,
      ...settings,
      font: localStorage.getItem(STORAGE.font) || DEFAULTS.font,
      theme: localStorage.getItem(STORAGE.theme) || DEFAULTS.theme,
      customTheme: readJSON(STORAGE.customTheme, null)
    };

    if (state.theme !== "custom" && !THEMES[state.theme]) {
      state.theme = DEFAULTS.theme;
    }

    if (state.theme === "custom" && !state.customTheme) {
      state.theme = DEFAULTS.theme;
    }

    state.fontSize = clampNumber(state.fontSize, 24, 320, DEFAULTS.fontSize);
    state.speed = clampNumber(state.speed, 2, 120, DEFAULTS.speed);
    state.rotation = clampNumber(state.rotation, -15, 15, DEFAULTS.rotation);
    state.gap = clampNumber(state.gap, 0, 300, DEFAULTS.gap);
    state.shadow = clampNumber(state.shadow, 0, 30, DEFAULTS.shadow);
    state.rows = Math.round(
      clampNumber(state.rows, 1, 8, DEFAULTS.rows)
    );

    if (!["alternate", "same"].includes(state.rowDirection)) {
      state.rowDirection = DEFAULTS.rowDirection;
    }
  }

  function setVariable(name, value) {
    root.style.setProperty(name, value);
  }

  function createMarqueeGroup(hidden = false) {
    const group = document.createElement("div");
    group.className = "marquee-group";

    if (hidden) group.setAttribute("aria-hidden", "true");

    for (let i = 0; i < 4; i += 1) {
      const button = document.createElement("button");
      button.className = "theme-button";
      button.type = "button";
      button.textContent = state.text;

      if (hidden) button.tabIndex = -1;

      group.append(button);

      const separator = document.createElement("span");
      separator.className = "separator";
      separator.setAttribute("aria-hidden", "true");
      group.append(separator);
    }

    return group;
  }

  function applyRowDirections() {
    if (!els.marqueeRows) return;

    const alternate = state.rowDirection === "alternate";

    els.marqueeRows.classList.toggle("mode-alternate", alternate);
    els.marqueeRows.classList.toggle("mode-same", !alternate);
  }

  function renderMarqueeRows() {
    if (!els.marqueeRows) return;

    const fragment = document.createDocumentFragment();

    for (let rowIndex = 0; rowIndex < state.rows; rowIndex += 1) {
      const row = document.createElement("div");
      row.className = "marquee-row";

      const track = document.createElement("div");
      track.className = "marquee-track";

      track.append(
        createMarqueeGroup(false),
        createMarqueeGroup(true)
      );

      row.append(track);
      fragment.append(row);
    }

    els.marqueeRows.replaceChildren(fragment);
    applyRowDirections();
  }

  function updateMarqueeText() {
    const text = String(state.text || "BoyOz").trim() || "BoyOz";
    state.text = text;
    $$(".theme-button", els.marqueeRows || document).forEach(button => {
      button.textContent = text;
    });
  }

  function loadGoogleFont(fontName) {
    if (!FONT_NAMES.includes(fontName)) fontName = DEFAULTS.font;

    const encoded = encodeURIComponent(fontName).replace(/%20/g, "+");

    if (els.googleFontStylesheet) {
      els.googleFontStylesheet.href =
        `https://fonts.googleapis.com/css2?family=${encoded}&display=swap`;
    }

    setVariable("--font-family", `"${fontName}"`);
    state.font = fontName;
  }

  function applyBaseTheme(theme) {
    setVariable("--bg-a", theme.bgA);
    setVariable("--bg-b", theme.bgB);
    setVariable("--text", theme.text);
    setVariable("--accent", theme.accent);
    setVariable("--shadow", theme.shadow);
    setVariable("--shadow-opacity", theme.shadowOpacity);
    setVariable("--glow", theme.glow);
  }

  function applyTheme(name, save = true) {
    const theme = THEMES[name];
    if (!theme) return;

    state.theme = name;
    applyBaseTheme(theme);

    if (els.themePicker) els.themePicker.value = name;
    if (els.customTheme) els.customTheme.hidden = true;

    if (save) saveState();

    playThemeFlash();
  }

  function playThemeFlash() {
    playInteractionFlash("theme");
  }

  function playInteractionFlash(type = "theme") {
    if (!els.themeFlash) return;

    els.themeFlash.classList.remove("play", "background-play");
    void els.themeFlash.offsetWidth;

    els.themeFlash.classList.add(
      type === "background" ? "background-play" : "play"
    );

    setTimeout(() => {
      els.themeFlash.classList.remove("play", "background-play");
    }, 650);
  }

  function hsl(h, s, l) {
    return `hsl(${Math.round(h)} ${Math.round(s)}% ${Math.round(l)}%)`;
  }

  function hslToRgb(h, s, l) {
    s /= 100;
    l /= 100;

    const k = n => (n + h / 30) % 12;
    const a = s * Math.min(l, 1 - l);
    const f = n => l - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));

    return [
      Math.round(255 * f(0)),
      Math.round(255 * f(8)),
      Math.round(255 * f(4))
    ];
  }

  function hslToHex(h, s, l) {
    return "#" + hslToRgb(h, s, l).map(value => value.toString(16).padStart(2, "0")).join("");
  }

  function hexToRgb(hex) {
    const match = String(hex).trim().match(/^#([0-9a-f]{6})$/i);
    if (!match) return null;

    const value = parseInt(match[1], 16);

    return {
      r: (value >> 16) & 255,
      g: (value >> 8) & 255,
      b: value & 255
    };
  }

  function getActiveThemeColors() {
    if (state.theme === "custom" && state.customTheme) {
      return state.customTheme;
    }

    return THEMES[state.theme] || THEMES[DEFAULTS.theme];
  }

  function isLightColor(color) {
    const rgb = hexToRgb(color);
    if (!rgb) return false;

    const luminance = (
      0.2126 * rgb.r +
      0.7152 * rgb.g +
      0.0722 * rgb.b
    ) / 255;

    return luminance > 0.58;
  }

  function generateRandomBackground() {
    const activeTheme = getActiveThemeColors();
    const keep = {
      bgA: activeTheme.bgA,
      bgB: activeTheme.bgB,
      text: activeTheme.text,
      accent: activeTheme.accent,
      shadow: activeTheme.shadow,
      shadowOpacity: activeTheme.shadowOpacity,
      glowHex: activeTheme.glowHex || "#d7b77c",
      glowOpacity: clampNumber(activeTheme.glowOpacity, 0, 100, 18)
    };

    const textIsLight = isLightColor(keep.text);
    const currentRgb = hexToRgb(keep.bgA);
    let hue = Math.floor(Math.random() * 360);

    if (currentRgb) {
      const currentHue = rgbToHue(currentRgb.r, currentRgb.g, currentRgb.b);
      hue = (currentHue + 45 + Math.floor(Math.random() * 270)) % 360;
    }

    const hueB = (hue + 14 + Math.random() * 32) % 360;

    if (textIsLight) {
      keep.bgA = hslToHex(
        hue,
        34 + Math.random() * 34,
        4 + Math.random() * 9
      );
      keep.bgB = hslToHex(
        hueB,
        30 + Math.random() * 35,
        11 + Math.random() * 12
      );
    } else {
      keep.bgA = hslToHex(
        hue,
        18 + Math.random() * 28,
        76 + Math.random() * 13
      );
      keep.bgB = hslToHex(
        hueB,
        12 + Math.random() * 24,
        89 + Math.random() * 8
      );
    }

    keep.glowHex = hslToHex(hue, textIsLight ? 55 : 42, textIsLight ? 76 : 68);
    keep.glow = hexToRgba(keep.glowHex, keep.glowOpacity);

    applyCustomTheme(keep);
    playInteractionFlash("background");
  }

  function rgbToHue(r, g, b) {
    r /= 255;
    g /= 255;
    b /= 255;

    const max = Math.max(r, g, b);
    const min = Math.min(r, g, b);
    const delta = max - min;

    if (delta === 0) return 0;

    let hue;

    if (max === r) {
      hue = ((g - b) / delta) % 6;
    } else if (max === g) {
      hue = (b - r) / delta + 2;
    } else {
      hue = (r - g) / delta + 4;
    }

    return Math.round(hue * 60 + (hue < 0 ? 360 : 0));
  }

  function generateRandomTheme() {
    const isLight = Math.random() > 0.5;
    const hue = Math.floor(Math.random() * 360);

    let bgA;
    let bgB;
    let accent;
    let text;
    let shadow;
    let shadowOpacity;

    if (isLight) {
      bgA = hslToHex(hue, 18 + Math.random() * 24, 74 + Math.random() * 15);
      bgB = hslToHex((hue + Math.random() * 25) % 360, 15 + Math.random() * 20, 88 + Math.random() * 10);
      accent = hslToHex((hue + 25 + Math.random() * 50) % 360, 45 + Math.random() * 33, 35 + Math.random() * 22);
      text = "#17202a";
      shadow = hslToHex(hue, 15 + Math.random() * 20, 55 + Math.random() * 15);
      shadowOpacity = (.24 + Math.random() * .14).toFixed(2);
    } else {
      bgA = hslToHex(hue, 35 + Math.random() * 30, 5 + Math.random() * 10);
      bgB = hslToHex((hue + Math.random() * 30) % 360, 35 + Math.random() * 30, 15 + Math.random() * 14);
      accent = hslToHex((hue + 20 + Math.random() * 60) % 360, 58 + Math.random() * 32, 58 + Math.random() * 20);
      text = "#f7f7f7";
      shadow = hslToHex(hue, 30 + Math.random() * 35, 2 + Math.random() * 7);
      shadowOpacity = (.78 + Math.random() * .16).toFixed(2);
    }

    const glowHex = hslToHex(
      (hue + 12 + Math.random() * 35) % 360,
      isLight ? 52 : 42,
      isLight ? 76 : 69
    );
    const glowOpacity = isLight ? 62 : 16;

    applyCustomTheme({
      bgA,
      bgB,
      text,
      accent,
      shadow,
      shadowOpacity,
      glowHex,
      glowOpacity,
      glow: hexToRgba(glowHex, glowOpacity)
    });

    playInteractionFlash("theme");
  }

  function applyCustomTheme(theme, save = true) {
    state.customTheme = {
      ...state.customTheme,
      ...theme
    };

    const glowHex = /^#[0-9a-f]{6}$/i.test(state.customTheme.glowHex || "")
      ? state.customTheme.glowHex
      : "#d7b77c";
    const glowOpacity = clampNumber(
      state.customTheme.glowOpacity,
      0,
      100,
      18
    );

    state.customTheme.glowHex = glowHex;
    state.customTheme.glowOpacity = glowOpacity;

    if (!state.customTheme.glow) {
      state.customTheme.glow = hexToRgba(glowHex, glowOpacity);
    }

    applyBaseTheme(state.customTheme);
    state.theme = "custom";

    if (els.themePicker) els.themePicker.value = "";

    if (save) saveState();

    syncCustomColorControls();
    showCustomTheme();
  }

  function hexToRgba(hex, opacity) {
    const rgb = hexToRgb(hex);
    const alpha = clampNumber(opacity, 0, 100, 0) / 100;

    if (!rgb) return `rgba(255, 255, 255, ${alpha.toFixed(2)})`;

    return `rgba(${rgb.r}, ${rgb.g}, ${rgb.b}, ${alpha.toFixed(2)})`;
  }

  function syncCustomColorControls() {
    const theme = state.customTheme;
    if (!theme) return;

    [
      ["colorBgA", "bgA"],
      ["colorBgB", "bgB"],
      ["colorText", "text"],
      ["colorAccent", "accent"],
      ["colorShadow", "shadow"]
    ].forEach(([id, key]) => {
      if (els[id] && theme[key] && /^#[0-9a-f]{6}$/i.test(theme[key])) {
        els[id].value = theme[key];
      }

      const output = $(`#${id}Value`);
      if (output) output.textContent = (theme[key] || "#000000").toUpperCase();
    });

    const glow = theme.glowHex || "#d7b77c";
    const opacity = Number(theme.glowOpacity ?? 18);

    if (els.colorGlow) els.colorGlow.value = /^#[0-9a-f]{6}$/i.test(glow) ? glow : "#d7b77c";
    if ($("#colorGlowValue")) $("#colorGlowValue").textContent = glow.toUpperCase();
    if (els.glowOpacity) els.glowOpacity.value = clamp(opacity, 0, 100);
    if ($("#glowOpacityValue")) $("#glowOpacityValue").textContent = `${clamp(opacity, 0, 100)}%`;
  }

  function showCustomTheme() {
    if (!els.customTheme || !els.themePicker) return;

    const active = els.themePicker.value === "";
    els.customTheme.hidden = !active;

    if (active) {
      if (!state.customTheme) {
        state.customTheme = {
          bgA: "#080808",
          bgB: "#211d19",
          text: "#f5f1e8",
          accent: "#d7b77c",
          shadow: "#070707",
          shadowOpacity: ".88",
          glowHex: "#d7b77c",
          glowOpacity: 18,
          glow: "rgba(215,183,124,.18)"
        };
      }

      syncCustomColorControls();
    }
  }

  function updateCustomControls() {
    state.customTheme = {
      ...state.customTheme,
      bgA: els.colorBgA.value,
      bgB: els.colorBgB.value,
      text: els.colorText.value,
      accent: els.colorAccent.value,
      shadow: els.colorShadow.value,
      glowHex: els.colorGlow.value,
      glowOpacity: Number(els.glowOpacity.value)
    };

    [
      ["colorBgA", "bgA"],
      ["colorBgB", "bgB"],
      ["colorText", "text"],
      ["colorAccent", "accent"],
      ["colorShadow", "shadow"],
      ["colorGlow", "glowHex"]
    ].forEach(([id, key]) => {
      const output = $(`#${id}Value`);
      if (output) output.textContent = state.customTheme[key].toUpperCase();
    });

    if ($("#glowOpacityValue")) {
      $("#glowOpacityValue").textContent = `${state.customTheme.glowOpacity}%`;
    }
  }

  function applyCustomFromControls() {
    updateCustomControls();

    const theme = state.customTheme;

    applyCustomTheme({
      bgA: theme.bgA,
      bgB: theme.bgB,
      text: theme.text,
      accent: theme.accent,
      shadow: theme.shadow,
      shadowOpacity: theme.shadowOpacity || ".88",
      glow: hexToRgba(theme.glowHex, theme.glowOpacity)
    });

    playInteractionFlash("theme");
  }

  function updateRangeLabels() {
    const values = {
      fontSize: $("#fontSizeValue"),
      speed: $("#speedValue"),
      rotation: $("#rotationValue"),
      gap: $("#gapValue"),
      shadow: $("#shadowValue"),
      rows: $("#rowsValue")
    };

    if (values.fontSize) values.fontSize.textContent = `${state.fontSize}px`;
    if (values.speed) values.speed.textContent = `${state.speed}s`;
    if (values.rotation) values.rotation.textContent = `${state.rotation}°`;
    if (values.gap) values.gap.textContent = `${state.gap}px`;
    if (values.shadow) values.shadow.textContent = `${state.shadow}px`;
    if (values.rows) values.rows.textContent = String(state.rows);
  }

  function syncControls() {
    if (els.textInput) els.textInput.value = state.text;
    if (els.fontPicker) els.fontPicker.value = state.font;

    if (els.fontSize) els.fontSize.value = state.fontSize;
    if ($("#fontSizeNumber")) $("#fontSizeNumber").value = state.fontSize;

    if (els.rows) els.rows.value = state.rows;
    if ($("#rowsNumber")) $("#rowsNumber").value = state.rows;

    if (els.rowDirection) els.rowDirection.value = state.rowDirection;
    applyRowDirections();

    if (els.speed) els.speed.value = state.speed;
    if ($("#speedNumber")) $("#speedNumber").value = state.speed;

    if (els.rotation) els.rotation.value = state.rotation;
    if ($("#rotationNumber")) $("#rotationNumber").value = state.rotation;

    if (els.gap) els.gap.value = state.gap;
    if ($("#gapNumber")) $("#gapNumber").value = state.gap;

    if (els.shadow) els.shadow.value = state.shadow;
    if ($("#shadowNumber")) $("#shadowNumber").value = state.shadow;

    if (els.themePicker) {
      els.themePicker.value = THEMES[state.theme] ? state.theme : "";
    }

    syncCustomColorControls();
    showCustomTheme();
    updateRangeLabels();
  }

  function applySettings() {
    setVariable("--font-size", `${state.fontSize}px`);
    setVariable("--speed", `${state.speed}s`);
    setVariable("--rotation", `${state.rotation}deg`);
    setVariable("--gap", `${state.gap}px`);
    setVariable("--shadow-depth", `${state.shadow}px`);

    updateMarqueeText();
    loadGoogleFont(state.font);
    updateRangeLabels();
  }

  let previousFocus = null;

  function openSettings() {
    previousFocus = document.activeElement;

    els.settingsPanel?.classList.add("open");
    els.settingsOverlay?.classList.add("open");
    els.settingsToggle?.setAttribute("aria-expanded", "true");
    els.settingsPanel?.setAttribute("aria-hidden", "false");

    setTimeout(() => els.textInput?.focus(), 80);
  }

  function closeSettings() {
    els.settingsPanel?.classList.remove("open");
    els.settingsOverlay?.classList.remove("open");
    els.settingsToggle?.setAttribute("aria-expanded", "false");
    els.settingsPanel?.setAttribute("aria-hidden", "true");

    if (previousFocus && typeof previousFocus.focus === "function") {
      previousFocus.focus();
    }
  }

  function resetAll() {
    state = {
      ...DEFAULTS,
      customTheme: null
    };

    try {
      localStorage.removeItem(STORAGE.settings);
      localStorage.removeItem(STORAGE.font);
      localStorage.removeItem(STORAGE.theme);
      localStorage.removeItem(STORAGE.customTheme);
    } catch {}

    renderMarqueeRows();
    applyTheme(DEFAULTS.theme, false);
    applySettings();
    syncControls();
    saveState();
  }

  function bindEvents() {
    els.settingsToggle?.addEventListener("click", () => {
      els.settingsPanel?.classList.contains("open") ? closeSettings() : openSettings();
    });

    els.settingsOverlay?.addEventListener("click", closeSettings);
    $(".close-settings")?.addEventListener("click", closeSettings);

    document.addEventListener("keydown", event => {
      if (event.key === "Escape" && els.settingsPanel?.classList.contains("open")) {
        closeSettings();
      }
    });

    els.marqueeRows?.addEventListener("click", event => {
      const target = event.target;
      const button = target && typeof target.closest === "function"
        ? target.closest(".theme-button")
        : null;

      if (!button) return;

      event.stopPropagation?.();
      generateRandomTheme();
    });

    els.scene?.addEventListener("click", event => {
      const target = event.target;
      const clickedText = target && typeof target.closest === "function"
        ? target.closest(".theme-button")
        : null;

      if (clickedText) return;

      generateRandomBackground();
    });

    els.textInput?.addEventListener("input", event => {
      state.text = event.target.value;
      updateMarqueeText();
      saveState();
    });

    els.fontPicker?.addEventListener("change", event => {
      state.font = event.target.value;
      loadGoogleFont(state.font);
      saveState();
    });

    const ranges = [
      ["fontSize", 24, 320, "--font-size", "px", "fontSizeNumber"],
      ["speed", 2, 120, "--speed", "s", "speedNumber"],
      ["rotation", -15, 15, "--rotation", "deg", "rotationNumber"],
      ["gap", 0, 300, "--gap", "px", "gapNumber"],
      ["shadow", 0, 30, "--shadow-depth", "px", "shadowNumber"]
    ];

    ranges.forEach(([key, min, max, variable, suffix, numberId]) => {
      els[key]?.addEventListener("input", event => {
        state[key] = clamp(Number(event.target.value), min, max);
        setVariable(variable, state[key] + suffix);

        const numberInput = $("#"+numberId);
        if (numberInput) numberInput.value = state[key];

        updateRangeLabels();
        saveState();
      });
    });

    els.rows?.addEventListener("input", event => {
      state.rows = clamp(Math.round(Number(event.target.value)), 1, 8);
      els.rows.value = state.rows;

      const numberInput = $("#rowsNumber");
      if (numberInput) numberInput.value = state.rows;

      renderMarqueeRows();
      updateMarqueeText();
      updateRangeLabels();
      saveState();
    });

    const numberInputs = [
      ["fontSizeNumber", "fontSize", 24, 320, "--font-size", "px"],
      ["speedNumber", "speed", 2, 120, "--speed", "s"],
      ["rotationNumber", "rotation", -15, 15, "--rotation", "deg"],
      ["gapNumber", "gap", 0, 300, "--gap", "px"],
      ["shadowNumber", "shadow", 0, 30, "--shadow-depth", "px"]
    ];

    numberInputs.forEach(([id, key, min, max, variable, suffix]) => {
      $("#"+id)?.addEventListener("input", event => {
        const raw = Number(event.target.value);
        if (!Number.isFinite(raw)) return;

        state[key] = clamp(raw, min, max);
        event.target.value = state[key];

        if (els[key]) els[key].value = state[key];

        setVariable(variable, state[key] + suffix);
        updateRangeLabels();
        saveState();
      });
    });

    $("#rowsNumber")?.addEventListener("input", event => {
      const raw = Number(event.target.value);
      if (!Number.isFinite(raw)) return;

      state.rows = clamp(Math.round(raw), 1, 8);
      event.target.value = state.rows;

      if (els.rows) els.rows.value = state.rows;

      renderMarqueeRows();
      updateMarqueeText();
      updateRangeLabels();
      saveState();
    });

    els.rowDirection?.addEventListener("change", event => {
      state.rowDirection = ["alternate", "same"].includes(event.target.value)
        ? event.target.value
        : DEFAULTS.rowDirection;

      applyRowDirections();
      saveState();
    });

    [
      "colorBgA",
      "colorBgB",
      "colorText",
      "colorAccent",
      "colorShadow",
      "colorGlow"
    ].forEach(id => {
      els[id]?.addEventListener("input", updateCustomControls);
    });

    els.glowOpacity?.addEventListener("input", updateCustomControls);
    els.applyCustomTheme?.addEventListener("click", applyCustomFromControls);
    els.randomTheme?.addEventListener("click", generateRandomTheme);
    els.randomBackground?.addEventListener("click", generateRandomBackground);
    els.reset?.addEventListener("click", resetAll);
  }

  function initializeIcons() {
    if (window.lucide && typeof window.lucide.createIcons === "function") {
      window.lucide.createIcons({attrs: {"aria-hidden": "true"}});
      return;
    }

    setTimeout(initializeIcons, 100);
  }

  function init() {
    loadState();

    if (state.theme === "custom" && state.customTheme) {
      applyCustomTheme(state.customTheme, false);
    } else {
      applyTheme(state.theme, false);
    }

    renderMarqueeRows();
    applySettings();
    syncControls();
    bindEvents();
    initializeIcons();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init, {once: true});
  } else {
    init();
  }
})();