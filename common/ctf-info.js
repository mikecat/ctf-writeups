"use strict";

// リンク先が設定されていないaタグを、spanに変換する
function disableUnsetLinks() {
	const rawTargets = document.getElementsByTagName("a"), targets = [];
	for (let i = 0; i < rawTargets.length; i++) {
		targets.push(rawTargets[i]);
	}
	for (let i = 0; i < targets.length; i++) {
		const elem = targets[i];
		if (!elem.hasAttribute("href") || elem.getAttribute("href") === "") {
			const newElem = document.createElement("span");
			while (elem.attributes.length > 0) {
				const attr = elem.attributes[0];
				elem.removeAttributeNode(attr);
				newElem.setAttributeNode(attr);
			}
			while (elem.firstChild) {
				const child = elem.firstChild;
				elem.removeChild(child);
				newElem.appendChild(child);
			}
			elem.replaceWith(newElem);
		}
	}
}

window.addEventListener("load", function() {
	disableUnsetLinks();
});
