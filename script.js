
let selectedCinemaButton = null;
let selectedDateButton = null;
let selectedTimeButton = null;


let selectedCinema = null;
let selectedDate = null;
let selectedTime = null;

let electedMovie = null;


document.addEventListener('DOMContentLoaded', function() {
    fetch('get_movies.php')
        .then(response => response.json())
        .then(data => {
            console.log(data); 
            renderMovies(data.movies, data.cinemas, data.movie_cinemas);
        })
        .catch(error => console.error('Ошибка:', error));

    document.getElementById('submit-button').addEventListener('click', function() {
        console.log('Кнопка "Отправить заявку" нажата');
    
        const email = document.getElementById('email-input').value;
    
        if (email.trim() === '' || !selectedCinemaButton || !selectedDate || !selectedTime) {
            alert('Пожалуйста, выберите кинотеатр, дату, время и введите корректный email');
            return;
        }
    
        console.log('Данные готовы к отправке на сервер');
        sendBookingData(email);
    });
});

function sendBookingData(email) {
    console.log('Отправка данных на сервер:', { email, selectedCinemaButton, selectedDate, selectedTime });
    const selectedMovie = document.getElementById('modal-title').textContent; // Получаем название фильма

    // Проверяем корректность электронного адреса
    if (!isValidEmail(email)) {
        alert('Пожалуйста, введите корректный email адрес');
        return;
    }

    // Отправка данных на сервер для сохранения в базе данных
    fetch('save_booking.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            email: email,
            movie_title: selectedMovie, // Передаем название фильма
            cinema_name: selectedCinemaButton.textContent,
            selected_date: selectedDate,
            selected_time: selectedTime,
        }),
    }).then(response => {
        if (response.ok) {
            console.log('Данные успешно сохранены в базе данных');

            // Очистить выбранные данные
            selectedCinemaButton.classList.remove('selected');
            selectedDateButton.classList.remove('selected');
            selectedTimeButton.classList.remove('selected');
            selectedCinemaButton = null;
            selectedDate = null;
            selectedTime = null;

            // Закрыть модальное окно
            document.getElementById('movie-modal').style.display = "none";

        // Отправить уведомление пользователю
        alert('Ваша заявка успешно отправлена! Билет придет на почту');
        } else {
            console.error('Произошла ошибка при сохранении данных');
        }
    }).catch(error => {
        console.error('Ошибка при обращении к серверу:', error);
    });

    // fetch('update_counter.php', {
    //     method: 'POST'
    // })
    // .then(response => {
    //     if (response.ok) {
    //         console.log('Счетчик посещений успешно обновлен');
    //     } else {
    //         console.error('Произошла ошибка при обновлении счетчика посещений');
    //     }
    // })
    // .catch(error => {
    //     console.error('Ошибка при обращении к серверу:', error);
    // });
}

function updateConsoleMessage() {
    const selectedMovie = document.getElementById('modal-title').textContent;

    if (selectedCinemaButton && selectedDate && selectedTime) {
        let message = `Запись на фильм "${selectedMovie}"`;
        message += ` в кинотеатре "${selectedCinemaButton.textContent}"`;
        message += ` ${selectedDate}`;
        message += ` в ${selectedTime}`;

        console.log(message);

        // Очистить выбранные данные
        selectedCinemaButton.classList.remove('selected');
        selectedDateButton.classList.remove('selected');
        selectedTimeButton.classList.remove('selected');
        selectedCinemaButton = null;
        selectedDate = null;
        selectedTime = null;

        // Закрыть модальное окно
        document.getElementById('movie-modal').style.display = "none";


    }
}

function isValidEmail(email) {
    // Регулярное выражение для проверки корректности email адреса
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Функция для форматирования даты в формате "дд.мм"
function formatDate(date) {
    const day = date.getDate();
    const month = (date.getMonth() + 1);
    return `${day < 10 ? '0' : ''}${day}.${month < 10 ? '0' : ''}${month}`;
}

// Функция для получения даты n дней вперед от текущей даты
function getDate(n) {
    const today = new Date();
    const targetDate = new Date(today);
    targetDate.setDate(today.getDate() + n);
    return targetDate;
}


function showModal(movie, cinemas, movieCinemas) {
    const modal = document.getElementById('movie-modal');
    const span = document.getElementsByClassName('close')[0];

    // Фильтруем кинотеатры для текущего фильма
    const filteredCinemas = movieCinemas.filter(mc => mc.movie_id == movie.id)
                                        .map(mc => cinemas.find(cinema => cinema.id == mc.cinema_id));

    // Проверяем, что cinemas определены и являются массивом
    if (!Array.isArray(filteredCinemas) || filteredCinemas.length === 0) {
        console.error('Ошибка: пустые или некорректные данные о кинотеатрах');
        return;
    }

    // Установите данные фильма в модальное окно
    document.getElementById('modal-poster').src = movie.poster;
    document.getElementById('modal-title').textContent = movie.title;

    // Генерируем кнопки кинотеатров
    const cinemaButtonsContainer = document.getElementById('cinema-buttons');
    cinemaButtonsContainer.innerHTML = '';
    filteredCinemas.forEach(cinema => {
        const button = document.createElement('button');
        button.textContent = cinema.name;
        button.onclick = () => {
            if (selectedCinemaButton) {
                selectedCinemaButton.classList.remove('selected');
            }
            selectedCinemaButton = button;
            selectedCinemaButton.classList.add('selected');
            selectCinema(cinema.id, cinemas);
        };
        cinemaButtonsContainer.appendChild(button);
    });

    // генерируем кнопки дат
    const dateButtonsContainer = document.getElementById('date-buttons');
    dateButtonsContainer.innerHTML = '';
    for (let i = 0; i < 5; i++) {
        const button = document.createElement('button');
        const date = getDate(i);
        button.textContent = formatDate(date);
        button.onclick = () => {
            if (selectedDateButton) {
                selectedDateButton.classList.remove('selected');
            }
            selectedDateButton = button;
            selectedDateButton.classList.add('selected');
            selectDate(date);
            renderTimeButtons(movie, date);
        };
        dateButtonsContainer.appendChild(button);
    }
    // По умолчанию отображаем время для текущей даты и времени
    renderTimeButtons(movie, new Date());

    // Показать модальное окно
    modal.style.display = "block";

    // Закрыть модальное окно при клике на <span> (x)
    span.onclick = function() {
        modal.style.display = "none";
    };

    // Закрыть модальное окно при клике вне модального окна
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
}
// Функция для отображения времени сеансов до конца выбранного дня
function renderTimeButtons(movie, selectedDate) {
    const timeButtonsContainer = document.getElementById('time-buttons');
    timeButtonsContainer.innerHTML = '';

    const showtimes = calculateShowtimes(movie, selectedDate);

    const endOfDay = new Date(selectedDate);
    endOfDay.setHours(23, 59, 59, 999); // Устанавливаем конец выбранного дня на 23:59:59.999

    showtimes.forEach(showtime => {
        // Проверяем, что сеанс меньше или равен концу выбранного дня
        if (showtime <= endOfDay) {
            const button = document.createElement('button');
            let timeToShow = button.textContent = showtime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            button.onclick = () => {
                if (selectedTimeButton) {
                    selectedTimeButton.classList.remove('selected');
                }
                selectedTimeButton = button;
                selectedTimeButton.classList.add('selected');
                selectTime(timeToShow);
            };
            timeButtonsContainer.appendChild(button);
        }
    });
}

// Функция для расчета следующих сеансов
function calculateShowtimes(movie, selectedDate) {
    const interval = 3 * 60 * 60 * 1000; // Интервал 3 часа в миллисекундах
    const now = new Date();
    const firstShow = new Date(movie.first_show_datetime);
    const showtimes = [];
    const currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0);

    let nextShow = new Date(selectedDate); // Создаем новый объект Date для выбранной даты

    // Устанавливаем время первого показа фильма для нового объекта Date
    nextShow.setHours(firstShow.getHours(), firstShow.getMinutes(), 0, 0);

    while (showtimes.length < 8) {
        // Проверяем, что выбранная дата больше текущей даты, или что время следующего показа больше текущего времени
        if (nextShow > now) {
            // Добавляем только те сеансы, которые еще не начались
            showtimes.push(new Date(nextShow));
        }
        nextShow.setTime(nextShow.getTime() + interval);
    }

    return showtimes;
}

function renderMovies(movies, cinemas, movieCinemas) {
    if (!Array.isArray(movies) || !Array.isArray(cinemas)) {
        console.error('Ошибка: некорректные данные о фильмах или кинотеатрах');
        return;
    }

    const moviesList = document.getElementById('movies-list');
    moviesList.innerHTML = '';

    const uniqueMovies = {};
    
    movies.forEach(movie => {
        if (!uniqueMovies[movie.id]) {
            uniqueMovies[movie.id] = movie;
        }
    });

    Object.values(uniqueMovies).forEach(movie => {
        const movieElement = document.createElement('div');
        movieElement.classList.add('movie');
        movieElement.innerHTML = `
            <img src="${movie.poster}" alt="${movie.title}">
            <div style="overflow: hidden;"><h3>${movie.title}</h3></div>
        `;
        movieElement.onclick = (event) => {
            showModal(movie, cinemas, movieCinemas);
            event.stopPropagation();
        };
        moviesList.appendChild(movieElement);
    });
}


function selectCinema(cinemaId, cinemas) {
    selectedCinema = getCinemaName(cinemaId, cinemas);
    selectedDate = null;
    if (selectedDateButton) {
        selectedDateButton.classList.remove('selected');
        selectedDateButton = null;
    }

    // Сбрасываем выбранное время и кнопку выбранного времени
    selectedTime = null;
    if (selectedTimeButton) {
        selectedTimeButton.classList.remove('selected');
        selectedTimeButton = null;
    }
}

function selectDate(date) {
    selectedDate = formatDate(date);
}

function selectTime(time) {
    selectedTime = time;
    updateConsoleMessage();
}

function getCinemaName(cinemaId, cinemasData) {
    const cinema = cinemasData.find(cinema => cinema.id === cinemaId);
    return cinema ? cinema.name : 'Unknown';
}

function updateConsoleMessage() {
    const selectedMovie = document.getElementById('modal-title').textContent;

    if (selectedCinemaButton && selectedDate && selectedTime) {
        let message = `Запись на фильм "${selectedMovie}"`;
        message += ` в кинотеатре "${selectedCinemaButton.textContent}"`;
        message += ` ${selectedDate}`;
        message += ` в ${selectedTime}`;

        console.log(message);
    }
}
