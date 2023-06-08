import 'package:flutter/widgets.dart';

const apiUrl = "https://localhost:7179/api";

// Базовые настрйоки для стилей
const primaryColor = Color.fromARGB(255, 50, 74, 89);
const singleSpace = 8.0;
const borderRadius = 10.0;
const errorIconSize = 100.0;
const taskReportIconSize = 100.0;

// Точки навигации
const loginRoute = "login";
const registerRoute = "register";
const profileRoute = "profile";
const teacherCodeRoute = "teacher-code";
const modulesRoute = "modules";
const submodulesRoute = "submodules";
const moduleCreateRoute = "module-create";
const moduleEditRoute = "edit-module";
const taskCreateRoute = "task-create";
const taskEditRoute = "task-edit";
const taskPartCreateRoute = "taskpart-create";
const taskPartEditRoute = "taskpart-edit";
const tasksRoute = "tasks";
const taskCompletionRoute = "task-completion";
const taskReportRoute = "task-report";
const studentsRoute = "students";
const teacherReportRoute = "teacher-report";

// Краткая информация о приложении
const appName = "";
const appDescription = "Приложение по рабочей тетради";
const workbook = "Spotlight 5";

// Строки для страницы входа
const loginHeader = "Вход";
const loginDescription = "Войдите в свой профиль";
const loginButtonLabel = "Войти";
const goToLoginButtonLabel = "Уже зарегистрированы?";

// Строки для страницы регистрации
const registerHeader = "Зарегистрироваться";
const registerDescription = "Создайте свой профиль";
const registerButtonLabel = "Регистрация";
const goToRegisterButtonLabel = "Еще не зарегистрированы?";

// Строки для страницы с кодом учителя
const teacherCodeHeader = "Код учителя";
const teacherCodeDescription = "Это ваш уникальный код, сообщите его ученикам";
const enterTeacherCodeDescription = "Введите код вашего учителя";

// Строки для страницы личного профиля
const profileHeader = "Личный профиль";
const profileDescription = "";
const logoutButtonLabel = "Выйти";

// Строки для страниц модулей
const moduleCreateHeader = "Создание модуля";
const moduleCreateDescription = "Создайте новый модуль";
const moduleEditHeader = "Редактирование модуля";
const moduleEditDescription = "Измените модуль";
const moduleTasksHeader = "Задания в модуле";

// Строки для страниц заданий
const taskCreateHeader = "Создание задания";
const taskCreateDescription = "Создайте новое задание";
const taskEditHeader = "Редактирование задания";
const taskEditDescription = "Измените задание";
const taskPartsHeader = "Части задания";

// Строки для страниц частей заданий
const taskPartCreateHeader = "Создание части задания";
const taskPartCreateDescription = "Создайте новую часть задания";
const taskPartEditHeader = "Редактирование части задания";
const taskPartEditDescription = "Измените часть задания";

// Строки для страниц выполнения заданий
const answerVariantsHeader = "Choose the correct answer:";
