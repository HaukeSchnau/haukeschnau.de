#import "template.typ": resume, header, resume_heading, edu_item, exp_item, project_item, skill_item

#show: resume

#header(
    name: "Hauke Schnau",
    phone: "0172 8284708",
    email: "hauke.schnau@studium.uni-hamburg.de",
    linkedin: "linkedin.com/in/haukeschnau",
    site: "haukeschnau.de",
)

#resume_heading[Ausbildung]
#edu_item(
    name: "Universität Hamburg",
    degree: "Bachelor of Science in Informatik; Aktueller Notendurchschnitt: 1,47",
    location: "Hamburg",
    date: "Okt. 2022 - heute"
)
#edu_item(
    name: "IGS Lilienthal",
    degree: "Abitur; Note: 1,5",
    location: "Lilienthal, Niedersachsen",
    date: "2013 - 2022"
)

#resume_heading[Berufserfahrung]
#exp_item(
  role: "Softwareentwickler (Werkstudent)",
    name: "Buildlinx GmbH",
    location: "Hamburg",
    date: "Okt. 2024 - heute",
    [Entwicklung von Webanwendungen für Hausmeister und Systemintegratoren zur Verwaltung von Gebäuden und Heizungsanlagen],
    [Entwicklung von Schnittstellen zu Hardware basierend auf EdgeX Foundry],
    [Design von Benuzteroberflächen],
)
#exp_item(
    role: "Softwareentwickler (Werkstudent)",
    name: "Check24 Vergleichsportal für Versicherungsprodukte GmbH",
    location: "Hamburg",
    date: "Aug. 2023 - Okt. 2024",
    [Entwicklung und Wartung von Softwareanwendungen in TypeScript (React) und PHP (Symfony)],
    [Analyse von Anforderungen und Umsetzung in technische Lösungen],
    [Durchführung von Code-Reviews und Qualitätssicherung, auch durch Softwaretests],
    [Performance-Optimierung und Fehlerbehebung],
)
#exp_item(
    role: "Webentwickler",
    name: "Freiberuflich",
    location: "Bremen und Hamburg",
    date: "Aug. 2022 - Dez. 2023",
    [Umsetzung von Webseiten für Künstler und kleine Unternehmen],
    [Suchmaschinenoptimierung],
)
#exp_item(
    role: "Softwareentwickler (Minijob)",
    name: "homevoice GmbH",
    location: "Bremen",
    date: "Aug. 2021 - Juli 2022",
    [Entwicklung von Softwareanwendungen zur Hausverwaltung mit Spring Boot (Java) und React],
)

#resume_heading("Projekte (Auswahl)")
#project_item(
    name: [#link("https://studienbuch.app")[Studienbuch]],
    skills: "TypeScript, React Native, SQL, Docker",
    date: "Aug. 2023 - heute",
    [Mobile Anwendung zur Verwaltung von Noten, Fehlzeiten, Hausaufgaben sowie der Einsicht von tagesaktuellen Vertretungsplänen für Schüler],
    [Entwurf und Umsetzung der Benutzeroberfläche],
    [Planung und Implementierung einer Local-First-Architektur],
    [Bis heute im aktiven Einsatz],
)
#project_item(
    name: [#link("https://github.com/HaukeSchnau/Corona-OHZ")[Corona OHZ]],
    skills: "Next.js, Python",
    date: "2021 - 2022",
    [Webanwendung zur Anzeige von aktuellen Corona-Statistiken für den Landkreis Osterholz],
    [Einfache Zusammenfassung aktueller regionaler Zahlen und Regeln],
)
#project_item(
    name: [#link("https://github.com/HaukeSchnau/Karaoke")[Karaoke-App]],
    skills: "",
    date: "2021 - 2022",
    [Anwendung zum Mitsingen von beliebigen Songs],
    [Trennung von Gesang und Instrumental durch KI-Algorithmus von Deezer],
)

#resume_heading("Technische Fähigkeiten")
#skill_item(
  category: "Sprachen",
  skills: "TypeScript, PHP, Go, Python, Java, SQL, Dart, ..."
)
#skill_item(
  category: "Frameworks",
  skills: "React & React Native, Next.js, Expo, Symfony, EdgeX Foundry, Flutter, Kirby CMS, ..."
)
#skill_item(
  category: "Werkeuge",
  skills: "Git, Docker, Linux, OpenAPI, ..."
)
