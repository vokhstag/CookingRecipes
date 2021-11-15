# CookingRecipes

### Приложение рецептов.

Приложение показывает рецепты блюд по категориям. Для использования необходимо зарегистрироваться.
Регистрация локальная, реализованна на Core Data. Каждый пользователь может добавлять блюда в избранное, и они будут сохранены в Core Data и доступны оффлайн.

---

__Данные для приложения берутся из https://www.themealdb.com__

[__Ссылка на черновик карты экранов__](https://www.figma.com/file/nE5BM1rhnuqGtXYl4VS6uL/RecipeApp?node-id=0%3A1)

##### Модели данных:
__1. Модель блюда:__
```
         "idMeal":Int,
         "strMeal": String,
         "strDrinkAlternate": String?,
         "strCategory": String,
         "strArea": String,
         "strInstructions": String,
         "strMealThumb": String?,
         "strTags": String?,
         "strYoutube": String?,
         "strIngredient1": String?,
         "strIngredient2": String?,
         "strIngredient3": String?,
         "strIngredient4": String?,
         "strIngredient5": String?,
         "strIngredient6": String?,
         "strIngredient7": String?,
         "strMeasure1": String?,
         "strMeasure2": String?,
         "strMeasure3": String?,
         "strMeasure4": String?,
         "strMeasure5": String?,
         "strMeasure6": String?,
         "strMeasure7": String?,
```
__2. Модель категорий:__
```
         "idCategory": Int,
         "strCategory": String,
         "strCategoryThumb": String?,
         "strCategoryDescription": String?
```
__3. Модель профиля пользователя:__
```
        "userId": Int,
        "userName": String,
        "login": String,
        "password": String,
        "isActive": Bool
```
---

В качестве архитектуры выбрал MVP
Для навигации используется роутер
---
#### Главный экран
Главный экран представляет из себя 2 контроллера - Container и content. 
Container содержит collection view который отображает все категории блюд.
Content view - Все блюда из выбранной категории.
