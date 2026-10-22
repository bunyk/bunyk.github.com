// Configuration
const ADD_USER_OPTION = '__add__'; // Sentinel value for the "add new user" dropdown item
const SESSION_SIZES = [5, 10, 30]; // Available session sizes, in exercises
const EMA_ALPHA = 0.5; // Smoothing factor for exponential moving average
const SHOW_ANSWER_DURATION = 3000; // ms to show the correct answer after a miss
const MAX_ANSWER_TIME = 30.0; // Maximum seconds to answer; also the heatmap color scale maximum
const DEFAULT_LANG = 'en';

// Slavic plural forms: one, few, many
function plural(n, one, few, many) {
    const mod10 = n % 10;
    const mod100 = n % 100;
    if (mod10 === 1 && mod100 !== 11) return one;
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return few;
    return many;
}

// Translations: values are strings, or functions taking the display arguments
const TRANSLATIONS = {
    en: {
        langName: 'English',
        appTitle: 'Multiplication Table Trainer',
        selectUser: 'Select user',
        addNewUser: 'Add new user...',
        newUsernamePlaceholder: 'Enter new username',
        addUser: 'Add User',
        cancel: 'Cancel',
        sessionButton: size => `${size} Exercises`,
        sessionResults: 'Session Results',
        sessionStat: (solved, seconds) => `Solved ${solved} exercises in ${seconds} seconds`,
        averageTime: seconds => `Average time: ${seconds}s`,
        averageTimeNa: 'Average time: N/A',
        exerciseProgress: (index, total, time) => `Exercise ${index}/${total} — ${time}`,
        enterUsername: 'Please enter a username',
        userExists: 'User already exists!',
        selectUserFirst: 'Please select a user first!',
        notAnswered: 'Not answered yet',
        tooltipTime: seconds => `Time: ${seconds}s`,
    },
    de: {
        langName: 'Deutsch',
        appTitle: 'Einmaleins-Trainer',
        selectUser: 'Benutzer wählen',
        addNewUser: 'Neuen Benutzer anlegen...',
        newUsernamePlaceholder: 'Neuer Benutzername',
        addUser: 'Anlegen',
        cancel: 'Abbrechen',
        sessionButton: size => `${size} Aufgaben`,
        sessionResults: 'Sitzungsergebnisse',
        sessionStat: (solved, seconds) => `${solved} Aufgaben in ${seconds} Sekunden gelöst`,
        averageTime: seconds => `Durchschnittszeit: ${seconds}s`,
        averageTimeNa: 'Durchschnittszeit: k. A.',
        exerciseProgress: (index, total, time) => `Aufgabe ${index}/${total} — ${time}`,
        enterUsername: 'Bitte einen Benutzernamen eingeben',
        userExists: 'Benutzer existiert bereits!',
        selectUserFirst: 'Bitte zuerst einen Benutzer wählen!',
        notAnswered: 'Noch nicht beantwortet',
        tooltipTime: seconds => `Zeit: ${seconds}s`,
    },
    uk: {
        langName: 'Українська',
        appTitle: 'Тренажер таблиці множення',
        selectUser: 'Виберіть користувача',
        addNewUser: 'Додати користувача...',
        newUsernamePlaceholder: 'Імʼя користувача',
        addUser: 'Додати',
        cancel: 'Скасувати',
        sessionButton: size => `${size} ${plural(size, 'приклад', 'приклади', 'прикладів')}`,
        sessionResults: 'Результати сесії',
        sessionStat: (solved, seconds) => `Розвʼязано ${solved} ${plural(solved, 'приклад', 'приклади', 'прикладів')} за ${seconds} с`,
        averageTime: seconds => `Середній час: ${seconds} с`,
        averageTimeNa: 'Середній час: н/д',
        exerciseProgress: (index, total, time) => `Приклад ${index}/${total} — ${time}`,
        enterUsername: 'Будь ласка, введіть імʼя користувача',
        userExists: 'Користувач уже існує!',
        selectUserFirst: 'Спочатку виберіть користувача!',
        notAnswered: 'Ще не розвʼязано',
        tooltipTime: seconds => `Час: ${seconds} с`,
    },
};

// State
let currentUser = null;
let currentLang = DEFAULT_LANG;
let currentProblem = null;
let currentAnswer = null;
let startTime = null;
let timerInterval = null;
let sessionTimerInterval = null;
let elapsedTime = 0;
let sessionStartTime = null;
let sessionActive = false;
let sessionElapsedTime = 0;
let sessionProblemList = [];
let sessionProblemIndex = 0;
let sessionSolvedProblems = [];

// DOM elements
const newUsernameInput = document.getElementById('new-username');
const confirmAddUserBtn = document.getElementById('confirm-add-user-btn');
const cancelAddUserBtn = document.getElementById('cancel-add-user-btn');
const userSelect = document.getElementById('user-select');
const langSelect = document.getElementById('lang-select');
const appTitle = document.getElementById('app-title');
const sessionResultsTitle = document.getElementById('session-results-title');
const problemSection = document.getElementById('problem-section');
const statsSection = document.getElementById('stats-section');
const sessionResultsSection = document.getElementById('session-results');
const sessionStatDisplay = document.getElementById('session-stat');
const sessionButtonsContainer = document.getElementById('session-buttons');
const sessionTimerDisplay = document.getElementById('session-timer');
const problemDisplay = document.getElementById('problem');
const answerInput = document.getElementById('answer-input');
const exerciseContent = document.getElementById('exercise-content');
const answerPanel = document.getElementById('answer-panel');
const fusePath = document.getElementById('fuse-path');
const spark = document.getElementById('spark');
const kaboomGroup = document.getElementById('kaboom');
const bombParts = document.getElementById('bomb-parts');
const FUSE_LENGTH = fusePath.getTotalLength();
const averageScoreDisplay = document.getElementById('average-score');
const heatmapContainer = document.getElementById('heatmap');

// Read all users from localStorage
function getUsers() {
    const usersData = localStorage.getItem('multiplicationUsers');
    return usersData ? JSON.parse(usersData) : {};
}

// Write all users back to localStorage
function saveUsers(users) {
    localStorage.setItem('multiplicationUsers', JSON.stringify(users));
}

// Stop the per-problem timer
function stopProblemTimer() {
    if (timerInterval) {
        clearInterval(timerInterval);
        timerInterval = null;
    }
}

// Show or hide an element via the hidden class
function show(el) {
    el.classList.remove('hidden');
}

function hide(el) {
    el.classList.add('hidden');
}

// Prevent input from losing focus during session
answerInput.addEventListener('blur', function() {
    if (sessionActive) {
        setTimeout(() => {
            if (sessionActive && document.activeElement !== answerInput) {
                answerInput.focus();
            }
        }, 0);
    }
});

// Translate a key, resolving function entries with the given arguments
function tr(key, ...args) {
    const entry = TRANSLATIONS[currentLang][key];
    return typeof entry === 'function' ? entry(...args) : entry;
}

// Parse user and language from the URI fragment
function readHash() {
    const params = new URLSearchParams(location.hash.slice(1));
    return { user: params.get('user') || '', lang: params.get('lang') || '' };
}

// Write user and language to the URI fragment
function writeHash() {
    const params = new URLSearchParams();
    if (currentUser) {
        params.set('user', currentUser);
    }
    if (currentLang !== DEFAULT_LANG) {
        params.set('lang', currentLang);
    }
    location.hash = params.toString();
}

// Apply user and language from the URI fragment, if valid
function applyHash() {
    const { user, lang } = readHash();
    if (lang && lang !== currentLang && TRANSLATIONS[lang]) {
        setLanguage(lang);
    }
    if (user && user !== currentUser && getUsers()[user]) {
        selectUser(user);
    }
}

// Switch the interface language and refresh all displayed texts
function setLanguage(lang) {
    currentLang = lang;
    langSelect.value = lang;

    document.title = tr('appTitle');
    appTitle.textContent = tr('appTitle');
    sessionResultsTitle.textContent = tr('sessionResults');
    newUsernameInput.placeholder = tr('newUsernamePlaceholder');
    confirmAddUserBtn.textContent = tr('addUser');
    cancelAddUserBtn.textContent = tr('cancel');

    loadUsers();
    createSessionButtons();
    if (currentUser && !sessionActive) {
        show(sessionButtonsContainer);
        updateStatistics();
    }
}

// Handle the language dropdown selection
function onLangSelectChange() {
    if (TRANSLATIONS[langSelect.value]) {
        setLanguage(langSelect.value);
        writeHash();
    }
}

// Initialize the app
function init() {
    // Populate the language dropdown
    langSelect.innerHTML = '';
    for (const lang of Object.keys(TRANSLATIONS)) {
        const option = document.createElement('option');
        option.value = lang;
        option.textContent = TRANSLATIONS[lang].langName;
        langSelect.appendChild(option);
    }

    // Start with the language from the URI fragment, then apply the fragment
    const { lang } = readHash();
    if (TRANSLATIONS[lang]) {
        currentLang = lang;
    }
    setLanguage(currentLang);
    applyHash();

    // Keep selection in sync when the fragment changes (e.g. user edits the URL)
    window.addEventListener('hashchange', applyHash);
}

// Create a start-session button for each configured session size
function createSessionButtons() {
    sessionButtonsContainer.innerHTML = '';
    for (const size of SESSION_SIZES) {
        const button = document.createElement('button');
        button.textContent = tr('sessionButton', size);
        button.onclick = () => startSession(size);
        // Preview which exercises this session size would pick
        button.onmouseenter = () => previewSessionProblems(size);
        button.onmouseleave = clearSessionPreview;
        sessionButtonsContainer.appendChild(button);
    }
}

// Highlight the cells a session of the given size would pick
function previewSessionProblems(size) {
    clearSessionPreview();
    if (!currentUser) return;
    for (const problem of generateSessionProblemList(size)) {
        const [row, col] = problem.split('*').map(Number);
        heatmapContainer.children[row * 10 + col]?.classList.add('session-preview');
    }
}

// Remove the session preview highlight from all cells
function clearSessionPreview() {
    heatmapContainer.querySelectorAll('.session-preview').forEach(cell => {
        cell.classList.remove('session-preview');
    });
}

// Point the dropdown at the current user, or the placeholder if none
function restoreUserSelection() {
    userSelect.value = currentUser || '';
    if (!userSelect.value) {
        userSelect.selectedIndex = 0;
    }
}

// Load users from localStorage and populate the dropdown
function loadUsers() {
    const users = getUsers();

    // Rebuild dropdown options
    userSelect.innerHTML = '';
    const placeholder = document.createElement('option');
    placeholder.value = '';
    placeholder.textContent = tr('selectUser');
    placeholder.disabled = true;
    userSelect.appendChild(placeholder);

    for (const username in users) {
        const option = document.createElement('option');
        option.value = username;
        option.textContent = username;
        userSelect.appendChild(option);
    }

    // "Add new user" entry at the end of the list
    const addUserOption = document.createElement('option');
    addUserOption.value = ADD_USER_OPTION;
    addUserOption.textContent = tr('addNewUser');
    addUserOption.style.fontStyle = 'italic';
    userSelect.appendChild(addUserOption);

    // Keep the current user selected, or fall back to the placeholder
    restoreUserSelection();

    // Hide session buttons until user is selected
    hide(sessionButtonsContainer);
}

// Show or hide the new username form (input plus Add User and Cancel)
function setAddUserVisible(visible) {
    const formElements = [newUsernameInput, confirmAddUserBtn, cancelAddUserBtn];
    formElements.forEach(visible ? show : hide);
    if (visible) {
        newUsernameInput.focus();
    }
}

// Discard the new username entry and hide the form
function cancelAddUser() {
    newUsernameInput.value = '';
    setAddUserVisible(false);
}

// Handle the user dropdown selection
function onUserSelectChange() {
    if (userSelect.value === ADD_USER_OPTION) {
        // Revert the dropdown to the current selection while the add field is open
        restoreUserSelection();
        setAddUserVisible(true);
    } else if (userSelect.value) {
        setAddUserVisible(false);
        selectUser(userSelect.value);
    }
}

// Handle Enter/Escape keys in the new username field
function handleUsernameKeyDown(event) {
    if (event.key === 'Enter') {
        addUser();
    } else if (event.key === 'Escape') {
        cancelAddUser();
    }
}

// Add a new user
function addUser() {
    const username = newUsernameInput.value.trim();
    if (!username) {
        alert(tr('enterUsername'));
        return;
    }
    
    const users = getUsers();
    
    if (users[username]) {
        alert(tr('userExists'));
        return;
    }
    
    users[username] = {};
    saveUsers(users);
    
    newUsernameInput.value = '';
    setAddUserVisible(false);
    loadUsers();
    
    // Select the new user
    selectUser(username);
}

// Select a user
function selectUser(username) {
    currentUser = username;
    restoreUserSelection();

    // Reflect the selection in the URI fragment
    writeHash();

    // Show session buttons
    show(sessionButtonsContainer);
    
    // Hide problem and stats sections
    problemSection.style.display = 'none';
    statsSection.style.display = 'block';
    sessionResultsSection.style.display = 'none';
    sessionTimerDisplay.textContent = '';
    
    // Update statistics display
    updateStatistics();
}

function generateSessionProblemList(problemCount) {
    const userData = getUsers()[currentUser] || {};

    // Split problems into already-tried (recorded EMA) and unseen
    const tried = [];
    const unseen = [];
    for (let i = 1; i <= 9; i++) {
        for (let j = 1; j <= 9; j++) {
            const key = `${i}*${j}`;
            const time = userData[key];
            if (time !== undefined) {
                tried.push({ key, time });
            } else {
                // Seeded by user and problem so the hover preview matches
                // the session that the button actually starts
                unseen.push({ key, time: MAX_ANSWER_TIME + seededRandom(currentUser + key) });
            }
        }
    }

    // Sort both groups hardest first
    tried.sort((a, b) => b.time - a.time);
    unseen.sort((a, b) => b.time - a.time);

    // Aim for ~1/3 of the session to be review of already-tried problems,
    // fill the rest with unseen ones, and top up from whichever group is left
    let picked = tried.slice(0, Math.floor(problemCount / 3));
    picked = picked.concat(unseen.slice(0, problemCount - picked.length));
    picked = picked.concat(tried.slice(Math.floor(problemCount / 3),
        Math.floor(problemCount / 3) + problemCount - picked.length));

    return shuffleArray(picked.map(p => p.key));
}

// Deterministic pseudo-random value in [0, 1) from a seed string
// (FNV-1a hash followed by an avalanche mix)
function seededRandom(seed) {
    let h = 2166136261;
    for (let i = 0; i < seed.length; i++) {
        h ^= seed.charCodeAt(i);
        h = Math.imul(h, 16777619);
    }
    h ^= h >>> 15;
    h = Math.imul(h, 2246822507);
    h ^= h >>> 13;
    return (h >>> 0) / 4294967296;
}

// Fisher-Yates shuffle algorithm
function shuffleArray(array) {
    const newArray = [...array];
    for (let i = newArray.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [newArray[i], newArray[j]] = [newArray[j], newArray[i]];
    }
    return newArray;
}

// Start a new session with the given number of exercises
function startSession(problemCount) {
    if (!currentUser) {
        alert(tr('selectUserFirst'));
        return;
    }
    
    sessionActive = true;
    sessionProblemIndex = 0;
    sessionSolvedProblems = [];
    sessionStartTime = Date.now();
    sessionElapsedTime = 0;

    // Generate session problem list
    sessionProblemList = generateSessionProblemList(problemCount);

    // Update UI
    hide(sessionButtonsContainer);
    problemSection.style.display = 'block';
    statsSection.style.display = 'none';
    sessionResultsSection.style.display = 'none';
    
    // Track elapsed time while the session runs
    updateSessionProgressDisplay();
    sessionTimerInterval = setInterval(() => {
        sessionElapsedTime = (Date.now() - sessionStartTime) / 1000;
        updateSessionProgressDisplay();
    }, 100);
    
    // Focus the input field
    answerInput.focus();
    
    // Start first problem
    startNewProblem();
}

// End the session
function endSession() {
    // Record the final elapsed time
    sessionElapsedTime = (Date.now() - sessionStartTime) / 1000;
    
    sessionActive = false;
    
    // Clear intervals
    stopProblemTimer();
    if (sessionTimerInterval) {
        clearInterval(sessionTimerInterval);
        sessionTimerInterval = null;
    }
    
    // Hide problem section
    problemSection.style.display = 'none';
    
    // Show session results
    sessionResultsSection.style.display = 'block';
    statsSection.style.display = 'block';
    
    show(sessionButtonsContainer);
    sessionTimerDisplay.textContent = '';
    
    // Update session stats
    sessionStatDisplay.textContent = tr('sessionStat', sessionSolvedProblems.length, sessionElapsedTime.toFixed(1));
    
    // Update overall statistics
    updateStatistics();
}

// Update session progress display
function updateSessionProgressDisplay() {
    const minutes = Math.floor(sessionElapsedTime / 60);
    const seconds = Math.floor(sessionElapsedTime % 60);
    const timeStr = `${minutes}:${seconds.toString().padStart(2, '0')}`;
    sessionTimerDisplay.textContent = tr('exerciseProgress', sessionProblemIndex + 1, sessionProblemList.length, timeStr);
}

// Start a new problem
function startNewProblem() {
    if (!sessionActive) return;
    
    // Clear any existing timer
    stopProblemTimer();
    
    // Select the problem at the current position in the session list
    currentProblem = sessionProblemList[sessionProblemIndex];
    const [a, b] = currentProblem.split('*').map(Number);
    currentAnswer = a * b;
    
    // Update problem display
    problemDisplay.textContent = `${a} \u00d7 ${b} = ?`;
    
    // Reset input and panels
    answerInput.value = '';
    show(exerciseContent);
    hide(answerPanel);
    hide(kaboomGroup);
    show(bombParts);
    answerInput.focus();
    
    // Start timer
    startTime = Date.now();
    elapsedTime = 0;
    updateBombFuse(0);

    timerInterval = setInterval(() => {
        elapsedTime = (Date.now() - startTime) / 1000;
        if (elapsedTime >= MAX_ANSWER_TIME) {
            handleMissedProblem();
            return;
        }
        updateBombFuse(elapsedTime / MAX_ANSWER_TIME);
    }, 100);
}

// Burn the bomb fuse down: fraction is the elapsed share of the answer time
function updateBombFuse(fraction) {
    const visible = FUSE_LENGTH * (1 - fraction);
    fusePath.style.strokeDasharray = `${visible} ${FUSE_LENGTH}`;
    const point = fusePath.getPointAtLength(visible);
    spark.setAttribute('transform', `translate(${point.x} ${point.y})`);
}

// Show the kaboom burst in place of the bomb for a second
function showKaboom() {
    hide(bombParts);
    show(kaboomGroup);

    // Restart the pop animation so repeated explosions animate again
    // (it keeps its finished, faded-out state otherwise)
    kaboomGroup.style.animation = 'none';
    kaboomGroup.getBoundingClientRect(); // flush styles so the reset takes effect
    kaboomGroup.style.animation = '';

    setTimeout(() => {
        hide(kaboomGroup);
        show(bombParts);
    }, SHOW_ANSWER_DURATION);
}

// Handle key down in answer input
function handleKeyDown(event) {
    if (event.key === 'Enter') {
        checkAnswer();
    }
}

// Check the user's answer
function checkAnswer() {
    if (currentProblem === null) return;
    
    const userAnswer = parseInt(answerInput.value);
    
    if (isNaN(userAnswer)) {
        return;
    }
    
    const endTime = Date.now();
    const timeTaken = (endTime - startTime) / 1000; // in seconds
    
    if (userAnswer === currentAnswer) {
        // Correct answer - update EMA
        updateUserData(currentProblem, timeTaken);
        sessionSolvedProblems.push(currentProblem);
        
        // Clear timer
        stopProblemTimer();
        
        // Advance and end the session when the whole list is worked through
        // (missed problems are added at the end, so retries are included)
        sessionProblemIndex++;
        if (sessionProblemIndex >= sessionProblemList.length) {
            endSession();
            return;
        }
        
        // Start new problem
        startNewProblem();
    } else {
        // Wrong answer
        handleMissedProblem();
    }
}

// Handle a missed problem (wrong answer or timeout): blow up the bomb,
// record the maximum time, show the correct answer, reschedule the problem
// at the end of the session, and move on
function handleMissedProblem() {
    showKaboom();

    // The miss costs the maximum time
    updateUserData(currentProblem, MAX_ANSWER_TIME);
    
    // Stop the per-problem timer
    stopProblemTimer();
    
    // If this was the last pending problem, add an earlier one first so the
    // retry is spaced out (spaced repetition)
    const wasLastPending = sessionProblemIndex === sessionProblemList.length - 1;
    if (wasLastPending && sessionSolvedProblems.length > 0) {
        const reviewProblem = sessionSolvedProblems[Math.floor(Math.random() * sessionSolvedProblems.length)];
        sessionProblemList.push(reviewProblem);
    }
    
    // Add the missed problem at the end of the session; its current slot is
    // left behind, so it stays pending exactly once even if missed repeatedly
    sessionProblemList.push(currentProblem);
    
    // Replace the exercise with the correct answer, then move on
    const [a, b] = currentProblem.split('*').map(Number);
    answerPanel.textContent = `${a} \u00d7 ${b} = ${currentAnswer}`;
    hide(exerciseContent);
    show(answerPanel);
    answerInput.value = '';
    setTimeout(() => {
        sessionProblemIndex++;
        startNewProblem();
    }, SHOW_ANSWER_DURATION);
}

// Update user data with EMA
function updateUserData(problem, timeTaken) {
    const users = getUsers();
    
    if (!users[currentUser]) {
        users[currentUser] = {};
    }
    
    const userData = users[currentUser];
    const previousEma = userData[problem];
    
    // Calculate new EMA
    // If no previous value, just use the current time
    // Otherwise: ema = alpha * current + (1 - alpha) * previous
    const newEma = previousEma !== undefined 
        ? EMA_ALPHA * timeTaken + (1 - EMA_ALPHA) * previousEma
        : timeTaken;
    
    userData[problem] = newEma;
    
    saveUsers(users);
}

// Update statistics display
function updateStatistics() {
    const userData = getUsers()[currentUser] || {};
    
    // Calculate average time
    const problemCount = Object.keys(userData).length;
    if (problemCount > 0) {
        const totalTime = Object.values(userData).reduce((sum, time) => sum + time, 0);
        const avgTime = totalTime / problemCount;
        averageScoreDisplay.textContent = tr('averageTime', avgTime.toFixed(2));
    } else {
        averageScoreDisplay.textContent = tr('averageTimeNa');
    }
    
    // Update heatmap
    updateHeatmap(userData);
}

// Update heatmap visualization
function updateHeatmap(userData) {
    // Clear existing heatmap
    heatmapContainer.innerHTML = '';
    
    // Find min and max times for color scaling
    const times = Object.values(userData);
    const minTime = times.length > 0 ? Math.min(...times) : 0;
    let maxTime = MAX_ANSWER_TIME;
    
    // Ensure min and max are different for color scaling
    if (minTime === maxTime) {
        maxTime = minTime + 1;
    }
    
    // Create 10x10 heatmap grid
    // Row 0: column headers (empty at [0,0], then 1-9 at [0,1-9])
    // Col 0: row headers (empty at [0,0], then 1-9 at [1-9,0])
    // Data cells: [1-9,1-9]
    for (let row = 0; row < 10; row++) {
        for (let col = 0; col < 10; col++) {
            const cell = document.createElement('div');
            cell.className = 'heatmap-cell';
            
            if (row === 0 && col === 0) {
                // Top-left corner - empty
                cell.textContent = '';
                cell.style.backgroundColor = '#f0f0f0';
            } else if (row === 0) {
                // Column header (show 1-9)
                cell.textContent = col;
                cell.style.backgroundColor = '#f0f0f0';
                cell.style.fontWeight = 'bold';
            } else if (col === 0) {
                // Row header
                cell.textContent = row;
                cell.style.backgroundColor = '#f0f0f0';
                cell.style.fontWeight = 'bold';
            } else {
                // Data cell (rows 1-9, cols 1-9)
                const problem = `${row}*${col}`;
                const time = userData[problem];
                
                cell.textContent = row * col;

                if (time !== undefined) {
                    // Scale color: green (fast) to red (slow)
                    const normalized = (time > maxTime) ? 1.0 : (time - minTime) / (maxTime - minTime);
                    const red = Math.floor(normalized * 255);
                    const green = Math.floor((1 - normalized) * 255);
                    cell.style.backgroundColor = `rgb(${red}, ${green}, 80)`;
                    cell.title = `${row} \u00d7 ${col} = ${row * col}\n${tr('tooltipTime', time.toFixed(2))}`;
                } else {
                    cell.style.backgroundColor = '#f0f0f0';
                    cell.title = `${row} \u00d7 ${col} = ${row * col}\n${tr('notAnswered')}`;
                }
            }
            
            heatmapContainer.appendChild(cell);
        }
    }
}

// Initialize on page load
window.onload = init;
