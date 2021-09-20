"use strict";

// このファイルがあるディレクトリを得る
const currentDirectory = (function() {
	const scriptElements = document.getElementsByTagName("script");
	const scriptElement = scriptElements[scriptElements.length - 1];
	const scriptUrl = scriptElement.getAttribute("src");
	return scriptUrl.replace(/\/[^\/]*$/, "/");
})();

// 使うライブラリを読み込む

function addStylesheet(url) {
	const elem = document.createElement("link");
	elem.setAttribute("rel", "stylesheet");
	elem.setAttribute("href", url);
	document.head.appendChild(elem);
}

function addScript(url) {
	const elem = document.createElement("script");
	elem.setAttribute("src", url);
	document.head.appendChild(elem);
}

// 独自定義
addStylesheet(currentDirectory + "common.css");

// highlight.js
addStylesheet("//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/styles/default.min.css");
addScript("//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/highlight.min.js");

// ハイライト用の拡張子と言語の対応
const languageList = {
	"c": "c",
	"h": "c",
	"cpp": "cpp",
	"hpp": "cpp",
	"cs": "csharp",
	"css": "css",
	"go": "go",
	"html": "html",
	"xml": "html",
	"svg": "html",
	"java": "java",
	"js": "javascript",
	"json": "javascript",
	"php": "php",
	"pl": "perl",
	"txt": "plaintext",
	"py": "python",
	"asm": "plaintext", // x86asm is not supported by default
	"s": "plaintext"
};

// よく使うツールの名前とURLの対応
const commonToolList = {
	"Firefox": {
		"ja": "https://www.mozilla.org/ja/firefox/new/",
		"en": "https://www.mozilla.org/en-US/firefox/new/"
	},
	"TkSQLite": {
		"": "http://reddog.s35.xrea.com/wiki/TkSQLite.html"
	},
	"7-Zip": {
		"ja": "https://sevenzip.osdn.jp/",
		"en": "https://www.7-zip.org/"
	},
	"VLC media player": {
		"ja": "https://www.videolan.org/vlc/index.ja.html",
		"en": "https://www.videolan.org/vlc/index.en_GB.html"
	},
	"CyberChef": {
		"": "https://gchq.github.io/CyberChef/"
	},
	"John the Ripper": {
		"": "https://www.openwall.com/john/"
	},
	"Johnny": {
		"": "https://openwall.info/wiki/john/johnny"
	},
	"Cheat Engine": {
		"": "https://www.cheatengine.org/"
	},
	"Ghidra": {
		"": "https://ghidra-sre.org/"
	},
	"Tera Term": {
		"ja": "https://ttssh2.osdn.jp/",
		"en": "https://ttssh2.osdn.jp/index.html.en"
	},
	"CS50 IDE": {
		"": "https://ide.cs50.io/"
	},
	"TDM-GCC": {
		"": "https://jmeubank.github.io/tdm-gcc/"
	},
	"libc-database": {
		"": "https://libc.rip/"
	},
	"RequestBin.com" : {
		"": "https://requestbin.com/"
	},
	"Integer factorization calculator": {
		"": "https://www.alpertron.com.ar/ECM.HTM"
	},
	"Sage Cell Server": {
		"": "https://sagecell.sagemath.org/"
	},
	"オンラインBrainf*ckデバッガ": {
		"": "http://moon.kmc.gr.jp/~prime/bf/env/"
	},
	"GIMP": {
		"": "https://www.gimp.org/"
	},
	"Ideone.com": {
		"": "https://ideone.com/"
	},
	"hashcat": {
		"": "https://hashcat.net/hashcat/"
	},
	"Wireshark": {
		"": "https://www.wireshark.org/"
	},
	"NASM": {
		"": "https://www.nasm.us/"
	},
	"dnSpy": {
		"": "https://github.com/dnSpy/dnSpy"
	},
	"Google Chrome": {
		"ja": "https://www.google.com/intl/ja/chrome/",
		"en": "https://www.google.com/intl/en_us/chrome/"
	},
	"factordb.com": {
		"": "http://factordb.com/"
	},
	"OEIS": {
		"ja": "https://oeis.org/?language=japanese",
		"en": "https://oeis.org/?language=english"
	},
	"Wolfram Alpha": {
		"": "https://www.wolframalpha.com/"
	},
	"TweakPNG": {
		"": "http://entropymine.com/jason/tweakpng/"
	},
	"APNG Disassembler": {
		"ja": "https://ja.osdn.net/projects/sfnet_apngdis/",
		"en": "https://osdn.net/projects/sfnet_apngdis/"
	},
	"Ophcrack": {
		"": "https://ophcrack.sourceforge.io/"
	},
	"Registry Explorer/RECmd": {
		"": "http://ericzimmerman.github.io/#!index.md"
	},
	"mimikatz": {
		"": "https://github.com/gentilkiwi/mimikatz"
	},
	"CrackStation": {
		"": "https://crackstation.net/"
	},
	"Z3": {
		"": "https://github.com/Z3Prover/z3"
	},
	"Stegseek": {
		"": "https://github.com/RickdeJager/stegseek"
	},
	"rockyou.txt": {
		"": "https://github.com/brannondorsey/naive-hashcat/releases"
	},
	"TSXBIN": {
		"": "http://www.net3-tv.net/~m-tsuchy/tsuchy/dlpage.htm"
	},
	"Volatility": {
		"": "https://www.volatilityfoundation.org/"
	},
	"MMSSTV": {
		"ja": "http://je3hht.g1.xrea.com/mmsstv/index.html",
		"en": "https://hamsoft.ca/pages/mmsstv.php"
	}
};

function getLanguage(ext) {
	const extLower = ext.toLowerCase();
	if (extLower in languageList) {
		return languageList[extLower];
	} else {
		console.log("warning: extension \"" + extLower + "\" is not registered.");
		return null;
	}
}

// コードのハイライトを行う
function highlightCode() {
	// コードへのリンクの下に、コードを展開する
	const codeLinks = document.getElementsByClassName("code-link");
	for (let i = 0; i < codeLinks.length; i++) {
		const elem = codeLinks[i];
		const target = elem.href;
		(function(e, t) {
			const binMode = e.hasAttribute("data-binary") && e.getAttribute("data-binary");
			const ext = (function() {
				if (binMode) {
					return "txt";
				} else if (e.hasAttribute("data-extension")) {
					return e.getAttribute("data-extension");
				} else {
					const matchRes = t.match(/\.([^\/]+)$/);
					if (matchRes) return matchRes[1];
					return null;
				}
			})();
			const lang = getLanguage(ext);
			const req = new XMLHttpRequest();
			req.onreadystatechange = function() {
				if (req.readyState === 4) {
					if (req.status === 200) {
						const preElement = document.createElement("pre");
						const codeElement = document.createElement("code");
						if (binMode && req.response) {
							const arr = new Uint8Array(req.response);
							let renderedText = "";
							for (let i = 0; i < arr.byteLength; i += 16) {
								let chars = "  |";
								let count = 0;
								renderedText += ("00000000" + i.toString(16)).substr(-8);
								renderedText += " ";
								for (let j = 0; j < 16 && i + j < arr.byteLength; j++) {
									const c = arr[i + j];
									renderedText += " " + ("00" + c.toString(16)).substr(-2);
									chars += 0x20 <= c && c < 0x7f ? String.fromCharCode(c) : ".";
									count++;
								}
								for (; count < 16; count++) renderedText += "   ";
								renderedText += chars + "|\n";
							}
							codeElement.appendChild(document.createTextNode(renderedText));
						} else {
							codeElement.appendChild(document.createTextNode(req.responseText));
						}
						if (lang) codeElement.classList.add("language-" + lang);
						preElement.appendChild(codeElement);
						if (e.hasAttribute("data-collapse") && e.getAttribute("data-collapse")) {
							const detailsElement = document.createElement("details");
							const summaryElement = document.createElement("summary");
							const divElement = document.createElement("div");
							summaryElement.classList.add("code-collapse");
							divElement.classList.add("code-collapse");
							for (let i = 0; i < e.childNodes.length; i++) {
								summaryElement.appendChild(e.childNodes[i].cloneNode());
							}
							divElement.appendChild(preElement);
							detailsElement.appendChild(summaryElement);
							detailsElement.appendChild(divElement);
							e.replaceWith(detailsElement);
							divElement.insertBefore(e, preElement);
						} else {
							e.parentNode.insertBefore(preElement, e.nextSibling);
						}
						if (binMode) {
							e.parentNode.insertBefore(document.createTextNode(" (binary)"), e.nextSibling);
						}
						hljs.highlightElement(codeElement);
					} else {
						const p = document.createElement("p");
						p.appendChild(document.createTextNode("code fetch error: " + req.status));
						e.parentNode.insertBefore(p, e.nextSibling);
					}
				}
			};
			req.responseType = binMode ? "arraybuffer" : "text";
			req.open("GET", t);
			req.send();
		})(elem, target);
	}

	// 直接書かれたコードをハイライトする
	const rawCodeBlocks = document.getElementsByTagName("code-block"), codeBlocks = [];
	for (let i = 0; i < rawCodeBlocks.length; i++) {
		codeBlocks.push(rawCodeBlocks[i]);
	}
	for (let i = 0; i < codeBlocks.length; i++) {
		const elem = codeBlocks[i];
		const pre = document.createElement("pre");
		const code = document.createElement("code");
		let text = "";
		for (let j = 0; j < elem.childNodes.length; j++) {
			text += elem.childNodes[j].textContent;
		}
		code.appendChild(document.createTextNode(text.replace(/^(\r\n|\r|\n)/, "")));
		if (elem.hasAttribute("data-extension")) {
			const lang = getLanguage(elem.getAttribute("data-extension"));
			if (lang) code.classList.add("language-" + lang);
		}
		pre.appendChild(code);
		elem.replaceWith(pre);
		hljs.highlightElement(code);
	}
}

// 言語の切り替えを有効化する
function setupLanguageSelector() {
	const languageSelectors = document.getElementsByTagName("language-selector");
	if (languageSelectors.length === 0) return;
	if (languageSelectors.length > 1) {
		console.log("warning: Multiple language-selector found. Only first one will be used.");
	}
	const languageSelector = languageSelectors[0];
	const rawNames = languageSelector.getAttribute("data-langlist");
	if (!rawNames) {
		console.log("error: data-langlist doesn't exist for language-selector");
		return;
	}
	const names = rawNames.split(",");
	if (names.length < 4) return; // 言語が1個の場合は、選ぶ必要が無い
	const selectLinkClass = "language-select-link";
	const classPrefix = "language-selector-";
	const selectorFunctions = {};
	const divElement = document.createElement("div");
	divElement.appendChild(document.createTextNode("["));
	for (let i = 1; i < names.length; i += 2) {
		const langName = names[i - 1];
		const langId = names[i];
		const spanTag = document.createElement("span");
		spanTag.appendChild(document.createTextNode(langName));
		spanTag.classList.add(classPrefix + langId);
		const aTag = document.createElement("a");
		aTag.appendChild(document.createTextNode(langName));
		aTag.classList.add(selectLinkClass);
		aTag.href = "#" + langId;
		const otherClasses = [];
		for (let j = 1; j < names.length; j += 2) {
			if (j != i) otherClasses.push(classPrefix + names[j]);
		}
		const clickHandler = (function(element, thisId, otherClasses) {
			const thisClass = classPrefix + thisId;
			return function() {
				const selectionElements = document.getElementsByClassName(selectLinkClass);
				for (let j = 0; j < selectionElements.length; j++) {
					selectionElements[j].style.display = "";
				}
				element.style.display = "none";
				const thisElements = document.getElementsByClassName(thisClass);
				for (let j = 0; j < thisElements.length; j++) {
					thisElements[j].style.display = "";
				}
				for (let j = 0; j < otherClasses.length; j++) {
					const otherElements = document.getElementsByClassName(otherClasses[j]);
					for (let k = 0; k < otherElements.length; k++) {
						otherElements[k].style.display = "none";
					}
				}
				const linkElements = document.getElementsByClassName("language-aware-link");
				for (let j = 0; j < linkElements.length; j++) {
					linkElements[j].hash = thisId;
				}
			};
		})(aTag, langId, otherClasses);
		selectorFunctions[langId] = clickHandler;
		aTag.addEventListener("click", clickHandler);
		if (i > 1) divElement.appendChild(document.createTextNode("] ["));
		divElement.appendChild(spanTag);
		divElement.appendChild(aTag);
	}
	divElement.appendChild(document.createTextNode("]"));
	languageSelector.replaceWith(divElement);
	const hash = location.hash.replace(/^#/, "");
	selectorFunctions[hash in selectorFunctions ? hash : names[1]]();
}

// よく使うツールへのリンクを張る
function addLinkToCommonTools() {
	const rawToolElements = document.getElementsByTagName("common-tool"), toolElements = [];
	for (let i = 0; i < rawToolElements.length; i++) {
		toolElements.push(rawToolElements[i]);
	}
	for (let i = 0; i < toolElements.length; i++) {
		const element = toolElements[i];
		let name = "";
		for (let j = 0; j < element.childNodes.length; j++) {
			name += element.childNodes[j].textContent;
		}
		if (name in commonToolList) {
			const toolUrls = commonToolList[name];
			const lang = element.hasAttribute("data-lang") ? element.getAttribute("data-lang") : "";
			let url = null;
			if (lang in toolUrls) {
				url = toolUrls[lang];
			} else if ("" in toolUrls) {
				url = toolUrls[""];
			} else {
				console.log("warning: URL for tool \"" + name + "\" and language \"" + lang + "\" is not registered.");
			}
			if (url) {
				const aElement = document.createElement("a");
				aElement.setAttribute("href", url);
				while (element.firstChild) {
					const c = element.firstChild;
					element.removeChild(c);
					aElement.appendChild(c);
				}
				element.replaceWith(aElement);
			}
		} else {
			console.log("warning: \"" + name + "\" is not registered as common tool name.");
		}
1	}
}

window.addEventListener("load", function() {
	highlightCode();
	setupLanguageSelector();
	addLinkToCommonTools();
});
