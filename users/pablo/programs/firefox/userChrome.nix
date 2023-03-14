{ colors, ... }:

with colors; ''

:root {
  --contrast: #101419;
  --background: #0e1217;
  --black: #15191e;
  --black2: #1a1e23;
  --foreground: #b6beca;
}

* {
	font-family: "Roboto", sans-serif !important;
	font-weight: 500 !important;
	font-size: 12px !important;
	--arrowpanel-background: var(--black) !important;
	--arrowpanel-border-color: var(--background) !important;
	--autocomplete-popup-highlight-background: var(--background) !important;

	--button-hover-bgcolor: var(--black2) !important;
	--button-primary-hover-bgcolor: var(--black2) !important;

	--in-content-border-hover: var(--black2) !important;
	--in-content-button-background-hover: var(--black2) !important;
	--in-content-item-hover: var(--black2) !important;

	--toolbarbutton-active-background: var(--black) !important;
}

::-webkit-scrollbar-thumb {
	background-color: var(--black2) !important;
}

.toolbar {
	background-color: var(--black) !important;
}

window,
#main-window,
#toolbar-menubar,
#TabsToolbar,
#PersonalToolbar,
#navigator-toolbox,
#sidebar-box {
	background-color: var(--background) !important;
	-moz-appearance: none !important;
	background-image: none !important;
	border: none !important;
}

.tab-background {
	background-color: var(--background) !important;
	border-color: none !important;
	margin-block: 0px !important;
}

.tab-background[selected="true"] {
	background-color: var(--contrast) !important;
	-moz-appearance: none !important;
	background-image: none !important;
	border: none !important;
}

.tabbrowser-tab:hover .tab-background {
	background-color: var(--black2) !important;
}

.tabbrowser-tab[fadein] {
	max-width: 100vw !important;
}

#urlbar {
	background-color: var(--black) !important;
}

#nav-bar {
	background-color: var(--background) !important;
	-moz-appearance: none !important;
	background-image: none !important;
	border: none !important;
	transition: margin 0.5s !important;
}

#TabsToolbar {
	z-index: 1000 !important;
}

.tabbrowser-tab {
	height: 40px !important;
	z-index: 1000 !important;
	padding: none !important;
	padding-inline: 0px !important;
}

#navigator-toolbox:not(:focus-within):not(:hover) #nav-bar {
	margin-top: -40px !important;
}

.tab-line {
	display: none !important;
}

.tab-icon-image:not([pinned]) {
	display: none !important;
}

.tab-label {
	-moz-box-flex: 1 !important;
	text-align: center !important;
	margin: 5px !important;
}

.tab-secondary-label {
	display: none !important;
}

.tabbrowser-tab .tab-label-container {
	margin-inline-end: 7px !important;
}

.tab-label-container {
	-moz-box-pack: center !important;
	-moz-box-orient: horizontal !important;
}

#tabbrowser-tabs {
	-moz-box-flex: 1 !important;
	text-align: center !important;
}

#tabs-newtab-button {
	display: none !important;
}

.tabbrowser-tab::before,
.tabbrowser-tab::after {
	display: none !important;
}

.tab-close-button {
	display: none !important;
	border-radius: 10px !important;
}

#identity-box,
#tracking-protection-icon-container {
	display: none !important;
}

#back-button>.toolbarbutton-icon {
	transform: scale(.85, .85) !important;
	animation: none !important;
	border: none !important;
	box-shadow: none !important;
}

#back-button:not(:hover),
#back-button:not(:hover) > .toolbarbutton-icon {
	background: none !important;
}

#back-button:hover,
#back-button:hover > .toolbarbutton-icon {
	border-radius: 2px !important;
}

#back-button {
	list-style-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADdcAAA3XAUIom3gAAAAHdElNRQfiAxMSNzVLQoGBAAAAb0lEQVQoz43ROQqDUBSF4UMEESKCBBehOODK7ezSWZnGJmuI4xp+66CX9077FXc40k1o+fCSFRoOOgKLa3Z6QosrNt5EFpesDDwtLlgYSSzOmZlILY758SW7ykO+cYzwWNLjTI9HSc5XS86ypP+6Tw/fVEqhFbEZAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE4LTAzLTE5VDE4OjU1OjUzKzAxOjAwq3ccegAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOC0wMy0xOVQxODo1NTo1MyswMTowMNoqpMYAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC') !important;
}

#forward-button {
	list-style-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADdcAAA3XAUIom3gAAAAHdElNRQfiAxMSOA3k2CXQAAAAbklEQVQoz5WRMQqDABAEF4UgKEIIPkKJii+3s7NLpY1N3qBR84axsPYOt1sYuNtdSZLEi5FG1yKk5U9tIQ86dioLiejZKC0k5sPK20JSBn4UFvJkYiG3kIwvM8npAt2Vc8J50onpFOVU7Y51PfcBtUFUSir+geUAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTgtMDMtMTlUMTg6NTY6MTMrMDE6MDDECqmDAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE4LTAzLTE5VDE4OjU2OjEzKzAxOjAwtVcRPwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII=') !important;
}

#whats-new-menu-button,
#star-button,
#pocket-button,
#save-to-pocket-button
#pageActionSeparator,
#pageActionButton,
#reader-mode-button {
	display: none !important;
}

#save-to-pocket-button {
	visibility: hidden !important;
}

#PanelUI-button {
	border-image-slice: 0 !important;
}

#urlbar-input {
	background-color: transparent !important;
	padding: 4px !important;
}

#urlbar-results {
	background-color: var(--black) !important;
	border-radius: 10px !important;
}

.urlbarView-body-inner {
	border-top: none !important;
}

#nav-bar {
	border-bottom: 0px !important;
	box-shadow: none !important;
}

#urlbar ::-moz-selection,
.searchbar-textbox ::-moz-selection {
	background-color: var(--foreground) !important;
	color: #000 !important;
}

#tabbrowser-tabpanels {
	background-color: var(--foreground) !important;
}

urlbar > #urlbar-background {
	background-color: var(--background) !important;
}
''
