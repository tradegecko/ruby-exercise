# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Quote.create(
    [
        {author: 'Judy Garland', content: 'Always be a first-rate version of yourself, instead of a second-rate version of somebody else.', hashtags: 'confidence'},
        {author: 'Steve Jobs', content: 'Stay hungry. Stay foolish.', hashtags: 'motivation'},
        {author: 'Mahatma Gandhi', content: 'A man is but of product of his thought. What he thinks he becomes.', hashtags: 'life, motivation'}
    ]
)


YandexLanguage.create(
    [
        {code: 'sq',language:'Albanian'},
        {code: 'en',language:'English'},
        {code: 'ar',language:'Arabic'},
        {code: 'hy',language:'Armenian'},
        {code: 'az',language:'Azerbaijan'},
        {code: 'af',language:'Afrikaans'},
        {code: 'eu',language:'Basque'},
        {code: 'be',language:'Belarusian'},
        {code: 'bg',language:'Bulgarian'},
        {code: 'bs',language:'Bosnian'},
        {code: 'cy',language:'Welsh'},
        {code: 'vi',language:'Vietnamese'},
        {code: 'hu',language:'Hungarian'},
        {code: 'ht',language:'Haitian (Creole)'},
        {code: 'gl',language:'Galician'},
        {code: 'nl',language:'Dutch'},
        {code: 'el',language:'Greek'},
        {code: 'ka',language:'Georgian'},
        {code: 'da',language:'Danish'},
        {code: 'he',language:'Yiddish'},
        {code: 'id',language:'Indonesian'},
        {code: 'ga',language:'Irish'},
        {code: 'it',language:'Italian'},
        {code: 'is',language:'Icelandic'},
        {code: 'es',language:'Spanish'},
        {code: 'kk',language:'Kazakh'},
        {code: 'ca',language:'Catalan'},
        {code: 'ky',language:'Kyrgyz'},
        {code: 'zh',language:'Chinese'},
        {code: 'ko',language:'Korean'},
        {code: 'la',language:'Latin'},
        {code: 'lv',language:'Latvian'},
        {code: 'lt',language:'Lithuanian'},
        {code: 'mg',language:'Malagasy'},
        {code: 'ms',language:'Malay'},
        {code: 'mt',language:'Maltese'},
        {code: 'mk',language:'Macedonian'},
        {code: 'mn',language:'Mongolian'},
        {code: 'de',language:'German'},
        {code: 'no',language:'Norwegian'},
        {code: 'fa',language:'Persian'},
        {code: 'pl',language:'Polish'},
        {code: 'pt',language:'Portuguese'},
        {code: 'ro',language:'Romanian'},
        {code: 'ru',language:'Russian'},
        {code: 'sr',language:'Serbian'},
        {code: 'sk',language:'Slovakian'},
        {code: 'sl',language:'Slovenian'},
        {code: 'sw',language:'Swahili'},
        {code: 'tg',language:'Tajik'},
        {code: 'th',language:'Thai'},
        {code: 'tl',language:'Tagalog'},
        {code: 'tt',language:'Tatar'},
        {code: 'tr',language:'Turkish'},
        {code: 'uz',language:'Uzbek'},
        {code: 'uk',language:'Ukrainian'},
        {code: 'fi',language:'Finish'},
        {code: 'fr',language:'French'},
        {code: 'hr',language:'Croatian'},
        {code: 'cs',language:'Czech'},
        {code: 'sv',language:'Swedish'},
        {code: 'et',language:'Estonian'},
        {code: 'ja',language:'Japanese'}
    ]
)