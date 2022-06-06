"use strict"; // チェックを有効化

/*
parseの結果返すやつ (問題情報)

category : 問題のカテゴリ (文字列)
name     : 問題名 (文字列)
solves   : その問題が何チームに解かれたか (数値)
value    : 問題の点数 (数値)
time     : 問題を解いた時刻 (JavaScriptのDateのコンストラクタに入れて認識される形式)
*/

function parse_RACTF(solves, challenges) {
	const challengeInfo = {};
	if (challenges && challenges.d) {
		for (let i = 0; i < challenges.d.length; i++) {
			const category = challenges.d[i].name;
			for (let j = 0; j < challenges.d[i].challenges.length; j++) {
				challengeInfo[challenges.d[i].challenges[j].id] = {
					category: category, solves: challenges.d[i].challenges[j].solve_count
				};
			}
		}
	}
	const result = [];
	for (let i = 0; i < solves.d.solves.length; i++) {
		const info = solves.d.solves[i];
		if (info !== null) {
			const parsed = {};
			if (info.challenge in challengeInfo) {
				parsed.category = challengeInfo[info.challenge].category;
				parsed.solves = challengeInfo[info.challenge].solves;
			}
			parsed.name = info.challenge_name;
			parsed.value = info.points;
			parsed.time = info.timestamp;
			result.push(parsed);
		}
	}
	return result;
}

function parse_rCTF(solves, challenges) {
	const result = [];
	for (let i = 0; i < solves.data.solves.length; i++) {
		const info = solves.data.solves[i];
		result.push({
			category: info.category,
			name: info.name,
			solves: info.solves,
			value: info.points,
			time: (new Date(info.createdAt)).toJSON()
		});
	}
	return result;
}

function parse_CTFd(solves, challenges) {
	const challengeSolves = {};
	if (challenges && challenges.data) {
		for (let i = 0; i < challenges.data.length; i++) {
			challengeSolves[challenges.data[i].id] = challenges.data[i].solves;
		}
	}
	const result = [];
	for (let i = 0; i < solves.data.length; i++) {
		const info = solves.data[i];
		const parsed = {
			category: info.challenge.category,
			name: info.challenge.name,
			value: info.challenge.value,
			time: info.date
		};
		if (info.challenge_id in challengeSolves) {
			parsed.solves = challengeSolves[info.challenge_id];
		}
		result.push(parsed);
	}
	return result;
}

function parse_WaniCTFd(solves, challenges) {
	const result = [];
	const targetId = solves.id;
	for (let i = 0; i < challenges.data.length; i++) {
		const info = challenges.data[i];
		const solver = info.solver;
		let solved = false;
		let solvedTime = null;
		let point = null;
		for (let j = 0; j < solver.length; j++) {
			if (solver[j].userid === targetId) {
				solved = true;
				solvedTime = (new Date(solver[j].created / 1000000)).toJSON();
				point = solver[j].point;
				break;
			}
		}
		if (solved) {
			result.push({
				category: info.category,
				name: info.title,
				solves: info.solved,
				value: point,
				time: solvedTime
			});
		}
	}
	return result;
}

function parse_SquareCTF(solves, challenges) {
	const challengeData = challenges[0], solveData = challenges[1];
	const categories = {}, solveCounts = {};
	for (let i = 0; i < challengeData.challenges.length; i++) {
		const challenge = challengeData.challenges[i];
		if (challenge.topics.length > 0) {
			categories[challenge.name] = challenge.topics[0];
		}
	}
	for (let i = 0; i < solveData.standings.length; i++) {
		const stats = solveData.standings[i].taskStats;
		for (name in stats) {
			if (name in solveCounts) {
				solveCounts[name]++;
			} else {
				solveCounts[name] = 1;
			}
		}
	}
	const result = [];
	for (let i = 0; i < solves.solves.length; i++) {
		const info = solves.solves[i];
		const challengeCategory = info.challenge in categories ? categories[info.challenge] : null;
		const solveCount = info.challenge in solveCounts ? solveCounts[info.challenge] : 0;
		result.push({
			category: challengeCategory,
			name: info.challenge,
			solves: solveCount,
			value: info.points,
			time: (new Date(info.timestamp * 1000)).toJSON()
		});
	}
	return result;
}

function parse_TFC_CTF(solves, challenges) {
	const challengeInfo = {};
	if (challenges && challenges.pageProps.challenges) {
		const clist = challenges.pageProps.challenges;
		for (let i = 0; i < clist.length; i++) {
			challengeInfo[clist[i].id] = {
				category: clist[i].category,
				name: clist[i].name,
				solves: clist[i].nrSolves
			};
		}
	}
	const result = [];
	const slist = solves.pageProps.team.solves;
	for (let i = 0; i < slist.length; i++) {
		const sid = slist[i].challengeId;
		const parsed = {};
		if (sid in challengeInfo) {
			parsed.category = challengeInfo[sid].category;
			parsed.name = challengeInfo[sid].name;
			parsed.solves = challengeInfo[sid].solves;
		} else {
			parsed.name = sid;
		}
		parsed.value = slist[i].challenge.points;
		parsed.time = slist[i].solvedAt;
		result.push(parsed);
	}
	return result;
}

function parse_SECCON_Beginners_CTF(solves, challenges) {
	const challengeInfo = {};
	if (challenges && challenges.challenges) {
		const clist = challenges.challenges;
		for (let i = 0; i < clist.length; i++) {
			challengeInfo[clist[i].id] = {
				category: clist[i].category,
				name: clist[i].name,
				solves: clist[i].solved,
				value: clist[i].point
			};
		}
	}
	const result = [];
	const slist = solves.solves;
	for (let i = 0; i < slist.length; i++) {
		const sid = slist[i].challenge_id;
		const parsed = {};
		if (sid in challengeInfo) {
			parsed.category = challengeInfo[sid].category;
			parsed.name = challengeInfo[sid].name;
			parsed.solves = challengeInfo[sid].solves;
			parsed.value = challengeInfo[sid].value;
		} else {
			parsed.name = sid;
		}
		parsed.time = slist[i].created_at;
		result.push(parsed);
	}
	return result;
}

const parsers = [
	parse_RACTF,
	parse_rCTF,
	parse_CTFd,
	parse_WaniCTFd,
	parse_SquareCTF,
	parse_TFC_CTF,
	parse_SECCON_Beginners_CTF
];

function parseJSON(jsonStr) {
	try {
		return JSON.parse(jsonStr);
	} catch (e) {
		if (jsonStr !== "" && console && console.warn) console.warn(e);
		return null;
	}
}

function escapeHTMLAttribute(str) {
	return ("" + str).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;"); // " <- Sakura Editor hack
}

function escapeHTML(str) {
	return ("" + str).replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function convert() {
	const solves = parseJSON(document.getElementById("input_solves").value);
	const challenges = parseJSON(document.getElementById("input_challenges").value);
	const parserSelect = parseInt(document.getElementById("select_parser").value);
	let parseResult = [];
	let parseResultQuality = 0;
	if (parserSelect >= 0) {
		try {
			parseResult = parsers[parserSelect](solves, challenges);
		} catch (e) {
			if (console && console.warn) console.warn(e);
		}
	} else {
		for (let i = 0; i < parsers.length; i++) {
			try {
				const resultCandidate = parsers[i](solves, challenges);
				let resultCandidateQuality = 0;
				if (resultCandidate && resultCandidate.length > 0) {
					if("category" in resultCandidate[0]) resultCandidateQuality++;
					if("name" in resultCandidate[0]) resultCandidateQuality++;
					if("solves" in resultCandidate[0]) resultCandidateQuality++;
					if("value" in resultCandidate[0]) resultCandidateQuality++;
					if("time" in resultCandidate[0]) resultCandidateQuality++;
					if (resultCandidate.length > parseResult.length ||
					(resultCandidate.length === parseResult.length && resultCandidateQuality > parseResultQuality)) {
						parseResult = resultCandidate;
						parseResultQuality = resultCandidateQuality;
					}
				}
			} catch (e) {}
		}
	}
	document.getElementById("output_json").value = JSON.stringify(parseResult);

	// カテゴリ順 → 名前順 にソート
	parseResult.sort(function(a, b) {
		const acat = ("category" in a) ? a.category : "";
		const bcat = ("category" in b) ? b.category : "";
		if (acat !== bcat) return acat < bcat ? -1 : 1;
		const aname = ("name" in a) ? a.name : "";
		const bname = ("name" in b) ? b.name : "";
		if (aname !== bname) return aname < bname ? -1 : 1;
		return 0;
	});

	let result = "";
	for (let i = 0; i < parseResult.length; i++) {
		const info = parseResult[i];
		let currentElement = "<li><a href=\"\" class=\"language-aware-link solved-challenge\"";
		if ("category" in info) currentElement += " data-category=\"" + escapeHTMLAttribute(info.category) + "\"";
		if ("solves" in info) currentElement += " data-solves=\"" + escapeHTMLAttribute(info.solves) + "\"";
		if ("value" in info) currentElement += " data-value=\"" + escapeHTMLAttribute(info.value) + "\"";
		if ("time" in info) currentElement += " data-time=\"" + escapeHTMLAttribute(info.time) + "\"";
		currentElement += "\n>";
		if ("name" in info) currentElement += escapeHTML(info.name);
		currentElement += "</a></li>\n";
		result += currentElement;
	}
	document.getElementById("output_html").value = result;
}

window.addEventListener("load", function() {
	document.getElementById("convert_button").addEventListener("click", convert);
});
