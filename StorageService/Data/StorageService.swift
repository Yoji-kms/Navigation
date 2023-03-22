//
//  PostStore.swift
//  StorageService
//
//  Created by Yoji on 04.03.2023.
//

import UIKit

final public class StorageService {
    private init() {}
    public static let shared = StorageService()
    
    public let posts: [Post] = [
        Post(title: "CVRCHES music",
             audio: [
                "04. My Enemy (Feat. Matt Berninger)",
                "06. Never Say Die",
                "08. Graves"
             ], video: [
                ("CHVRCHES - Over", "https://www.youtube.com/embed/8ecVwQIUTHA"),
                ("CHVRCHES - The Mother We Share", "https://www.youtube.com/embed/_mTRvJ9fugM"),
                ("CHVRCHES - Good Girls", "https://www.youtube.com/embed/du4kNAyjVCg")
             ],
             likes: 20215,
             views: 125214),
        Post(title: "Ed Sheeran music",
             audio: [
                "02. Castle On The Hill",
                "06. Galway Girl",
                "13. Barcelona"
             ],video: [
                ("Ed Sheeran - Shivers", "https://www.youtube.com/embed/Il0S8BoucSA"),
                ("Ed Sheeran - Bad Habits", "https://www.youtube.com/embed/orJSJGHjBLI"),
                ("Ed Sheeran, Pokémon - Celestial", "https://www.youtube.com/embed/23g5HBOg3Ic")
             ],
             likes: 144221,
             views: 215420),
        
        Post(title: "Песочный человек",
             description: "\"Сэндмену\" недаром нет равных среди графических романов по числу престижных наград и премий, равно как и по числу похвальных отзывов критиков и читателей. \"Сэндмен\" — это полный тайн и открытий сюжет с глубоким философским подтекстом, прописанный гениальным пером Нила Геймана и иллюстрированный лучшими художниками в жанре комикса, \"Сэндмен\" — это колдовская смесь мифа и темной фэнтези, где сплетаются воедино множество жанров, от исторического романа до детектива. Подобных саг, где одна таинственная, будоражащая душу, история плавно перетекает в другую, не менее таинственную, мир графических романов прежде не видел. Однажды прочитав, \"Сэндмена\" невозможно забыть.",
             image: "Photos/sandman",
             likes: 455,
             views: 4444),
        Post(title: "Ключи Локков",
             description: "\"Ключи Локков\", написанные Джо Хиллом и нарисованные Габриэлем Родригезом, расскажут вам о Доме Ключей, необычном особняке в Новой Англии, сказочные двери которого изменяют каждого, кто осмелится пройти сквозь них... где обидает переполненное ненавистью, жестокое существо, что не упокоится, пока не отворит самую страшную из дверей.",
             image: "Photos/LockeAndKey",
             likes: 455,
             views: 562),
        Post(title: "Академия Амбрелла",
             description: "Это нестандартный, свежий и яркий комикс. В центре повествования – команда супергероев, которые встречаются вновь после смерти их приёмного отца – Профессора, чтобы в очередной раз спасти мир. Но у них нет плащей и обтягивающего трико – они обычные  люди со своими проблемами, просто чуть-чуть сильнее. В российском издании обе части комикса  – \"Сюита Апокалипсиса\" и  \"Даллас\". В первой – весь мир под угрозой... музыки, а \"Даллас\"расскажет свою версию событий убийства президента Кеннеди.",
             image: "Photos/UmbrellaAcademy",
             likes: 44,
             views: 312),
        Post(title: "Хранители",
             description: "Альтернативная реальность. 1985-й год. Президентом США все еще является Никсон и Холодная война все так же актуальна. Восемь лет назад супергерои были объявлены вне закона. Теперь они живут как обычные люди, хотя прежние годы регулярно дают о себе знать. И вот один из них жестоко убит. Люди, убравшие свои разноцветные костюмы в шкафы, не стали бы этим интересоваться, если бы не настойчивость единственного, кто не сдался семь лет назад, — Роршаха. На дворе самый разгар Холодной войны, у его бывших коллег разные профессии и взгляды на мир, а Роршах уверен, что все они оказались в эпицентре злодейского заговора.",
             image: "Photos/Watchmen",
             likes: 453,
             views: 8512),
        Post(title: "Сказки",
             description: "Представьте себе, что все наши самые любимые сказки оказались реальными людьми и поселились среди нас, сохранив все свои волшебные свойства. Как им удастся выжить в нашем обыкновенном, лишенном колдовства мире? «СКАЗКИ» - великолепная вариация на тему сказочного канона, придуманная Биллом Уиллингхэмом, дает ответ на этот вопрос. К нам возвращаются Бела Снежка и Бигби Волк, Златовласка и Мальчик-Пастушок – возвращаются как изгнанники, которые живут, хитроумно замаскировавшись, в одном из районов Нью-Йорка под названием Сказкитаун.",
             image: "Photos/Fables",
             likes: 5,
             views: 15)
    ]
    
    public let photos: [UIImage] = {
        let photosStrings: [String] = [
            "Photos/Dai Dark",
            "Photos/Dorohedoro",
            "Photos/Fables",
            "Photos/Lock and Key",
            "Photos/LockeAndKey",
            "Photos/ManyDeathsLailaStarr",
            "Photos/ManyDeathsLailaStarr 2",
            "Photos/Maus",
            "Photos/Miracleman_Vol_1_1",
            "Photos/Parasyte",
            "Photos/Sandman drem hunters",
            "Photos/Sandman Overture",
            "Photos/sandman",
            "Photos/Scott Pilgrim",
            "Photos/Seconds",
            "Photos/The Walking Dead 1",
            "Photos/The Walking Dead 2",
            "Photos/The Walking Dead 3",
            "Photos/The-Boys",
            "Photos/UmbrellaAcademy",
            "Photos/Watchmen"
        ]
        var photos: [UIImage] = []
        photosStrings.forEach {
            guard let image = UIImage(named: $0) else { return }
            photos.append(image)
        }
        return photos
    }()
}
