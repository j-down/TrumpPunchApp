//
//  TPPerson.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation

class TPPerson: NSObject, NSCoding {
    
    var name: String
    var price: String
    var body: String
    var unlocked: Bool
    
    var quotes = [String]()
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("people")
    
    struct PersonName {
        
        static let donaldTrump = "Donald Trump"
        static let hillaryClinton = "Hillary Clinton"
        static let bernieSanders = "Bernie Sanders"
        static let pewDiePie = "PewDiePie"
        static let jimmyFallon = "Jimmy Fallon"
        static let mileyCyrus = "Miley Cyrus"
        static let justinBieber = "Justin Bieber"
        static let kanyeWest = "Kanye West"
        static let kimKardashian = "Kim Kardashian"
    }
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let priceKey = "price"
        static let bodyKey = "body"
        static let unlockedKey = "unlocked"
    }
    
    init(name: String = "Setup", price: String = "0", body: String = "Setup", unlocked: Bool = false) {
        
        self.name = name
        self.price = price
        self.body = body
        self.unlocked = unlocked
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
        aCoder.encode(body, forKey: PropertyKey.bodyKey)
        aCoder.encode(unlocked, forKey: PropertyKey.unlockedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let price = aDecoder.decodeObject(forKey: PropertyKey.priceKey) as! String
        let body = aDecoder.decodeObject(forKey: PropertyKey.bodyKey) as! String
        let unlocked = aDecoder.decodeBool(forKey: PropertyKey.unlockedKey)
        
        self.init(name: name, price: price, body: body, unlocked: unlocked)
        
    }
    
    func toAny() -> Any {
        
        return [
            
            "name" : name,
            "price" : price,
            "body" : body,
            "unlocked" : unlocked
        ]
    }
}

//MARK: Quotes
extension TPPerson {
    
    func quote() -> String {
        
        if name == PersonName.donaldTrump {
            
            return donaldTrumpQuote()
        }
        else if name == PersonName.bernieSanders {
            
            return bernieSandersQuote()
        }
        else if name == PersonName.hillaryClinton {
            
            return hillaryClintonQuote()
        }
        else if name == PersonName.jimmyFallon {
            
            return jimmyFallonQuote()
        }
        else if name == PersonName.justinBieber {
            
            return justinBieberQuote()
        }
        else if name == PersonName.kanyeWest {
            
            return kanyeWestQuote()
        }
        else if name == PersonName.kimKardashian {
            
            return kimKardashianQuote()
        }
        else if name == PersonName.mileyCyrus {
            
            return mileyCyrusQuote()
        }
        else if name == PersonName.pewDiePie{
            
            return pewDiePieQuote()
        }
        
        return ""
    }
    
    func donaldTrumpQuote() -> String {
        
        quotes = []
        
        quotes.append("\"Listen you mother f****r, we're going to tax you 25 percent!\"")
        quotes.append("\"You know, it really doesn't matter what [the media] write as long as you've got a young and beautiful piece of ass.\"")
        quotes.append("\"When was the last time anybody saw us beating, let's say, China in a trade deal? They kill us. I beat China all the time. All the time. \"")
        quotes.append("\"I will build a great wall, and nobody builds walls better than me, believe me.\"")
        quotes.append("\"The wall will go up and Mexico will start behaving.\"")
        quotes.append("\"Laziness is a trait in the blacks.\"")
        quotes.append("\"If I were running 'The View,' I'd fire Rosie. I mean, I'd look her right in that fat, ugly face of hers, I'd say, 'Rosie, you're fired.' \"")
        quotes.append("\"Hillary Clinton was the worst Secretary of State in the history of the United States\"")
        quotes.append("\"If you can't get rich dealing with politicians, there's something wrong with you.\"")
        quotes.append("\"All of the women on The Apprentice flirted with me, consciously or unconsciously. That's to be expected.\"")
        quotes.append("\"One of the key problems today is that politics is such a disgrace. \"")
        quotes.append("\"The beauty of me is that I'm very rich.\"")
        quotes.append("\"It's freezing and snowing in New York we need global warming!\"")
        quotes.append("\"I've said if Ivanka weren't my daughter, perhaps I'd be dating her\"")
        quotes.append("\"My fingers are long and beautiful, as, it has been well documented, are various other parts of my body.\"")
        quotes.append("\"I have never seen a thin person drinking Diet Coke.\"")
        quotes.append("\"The point is, you can never be too greedy. \"")
        quotes.append("\"I have so many fabulous friends who happen to be gay, but I am a traditionalist. \"")
        quotes.append("\"I'm the worst thing that's ever happened to Isis.\"")
        quotes.append("\"I've said if Ivanka weren't my daughter, perhaps I'd be dating her\"")
        quotes.append("\"I've said if Ivanka weren't my daughter, perhaps I'd be dating her\"")
        quotes.append("\"I've said if Ivanka weren't my daughter, perhaps I'd be dating her\"")
        
        return quotes[Int(arc4random_uniform(19))]
    }
    
    func hillaryClintonQuote() -> String {
        
        quotes = []
        
        quotes.append("\"Religious beliefs and structural biases have to be changed. \"")
        quotes.append("\"We are going to take things away from you on behalf of the common good.\"")
        quotes.append("\"I have to confess that it's crossed my mind that you could not be a Republican and a Christian. \"")
        quotes.append("\"God bless the America we are trying to create.\"")
        quotes.append("\"We have a lot of kids who don't know what work means. They think work is a four letter word.\"")
        quotes.append("\"[On Bill Clinton] If I didn't kick his ass every day he'd be worth nothing.\"")
        quotes.append("\"I'm not going to have some reporters pawing through our papers.\"")
        quotes.append("\"I'm undaunted in my quest to amuse myself by constantly changing my hair.\"")
        quotes.append("\"[On Bill Clinton] Who's going to find out? These women are trash. Nobody's going to believe them.\"")
        quotes.append("\"I believe that the rights of women and girls is the unfinished business of the 21st century\"")
        quotes.append("\"The American people are tired of liars and people who pretend to be something they are not. \"")
        quotes.append("\"[On a trip to Bosnia] I remember landing under sniper fire. [Yeah... That just straight up didn't happen]\"")
        quotes.append("\"I suppose I could have stayed home and baked cookies and had teas, but what I decided to do was fulfill my passion which I entered before my husband was in public life.\"")
        quotes.append("\"I never took a position on Keystone until I took a position on Keystone\"")
        quotes.append("\"A right-wing network was after his presidency... including perverting the Constitution.\"")
        quotes.append("\"My husband may have his faults, but he has never lied to me.\"")
        
        return quotes[Int(arc4random_uniform(14))]
    }
    
    func justinBieberQuote() -> String {
        
        quotes = []
        
        quotes.append("\"I'm not sure about [political] parties. But whatever they have in Korea, that's bad\"")
        quotes.append("\"Honestly, I think the pissing in the bucket wasn't as big a deal as people made it seem.\"")
        quotes.append("\"You don't need to go to church to be a Christian. If you go to Taco Bell, that doesn't make you a taco.\"")
        quotes.append("\"As hard as I've tried. I don't know how to not be adorable.\"")
        quotes.append("\"I wear black diamonds instead of regular ones because I'm not flashy, just flossssy\"")
        quotes.append("\"F**k Bill Clinton! [shouted while urinating into a restaurant mop bucket]\"")
        quotes.append("\"I used to freak out at arcades, but now I'm like, whatever.\"")
        quotes.append("\"Michael [Jackson] is my inspiration. I want to emulate his career as much as possible.\"")
        quotes.append("\"I know that you guys don't judge me, do you? You guys love me just as much, even though I'm throwing up all over stage.\"")
        quotes.append("\"Sunday comes after Saturday.  Weird?\"")
        quotes.append("\"A girl could be sitting on her computer, trying to get noticed by me, and not knowing she's the future Mrs. Bieber\"")
        quotes.append("\"My first date has been…mythologized as ‘Bieber’s Dating Disaster.’ I took her to a buffet restaurant. Yes, I wore a white shirt. Yes, I got spaghetti.\"")
        quotes.append("\"Young people in the business have grown up and made the wrong decisions, or bad decisions, and haven’t been good role models. \"")
        quotes.append("\"I have dumped a girl over the phone. It’s terrible, isn’t it? We got into an argument during a phone call, so I basically said, ‘I don’t wanna be with you anymore,’ and she cried. \"")
        quotes.append("\"When you are following me on Twitter, you are literally following my life. I think that’s pretty cool.\"")
        quotes.append("\"I have a swagger coach that helps me and teaches me different swaggerific things to do\"")
        
        return quotes[Int(arc4random_uniform(14))]
        
    }
    
    func pewDiePieQuote() -> String {
        
        quotes = []
        
        quotes.append("\"When I started my YouTube channel in 2010, I never imagined that one day it would be the most subscribed channel in the world and that I would be a part of such a great community.\"")
        quotes.append("\"Everyone has played video games at some point these days, and video games are fun.\"")
        quotes.append("\"I'm just so very lucky to be able to do what I do for a living, and giving back is a way for me to express my gratitude. I'm so lucky to be in a position to help people, and that's appealing to me.\"")
        quotes.append("\"It was so much easier to connect with my fans when I was smaller. I could answer every message, and I enjoyed doing that.\"")
        quotes.append("\"My parents said that sitting at home playing video games all day won't bring you anywhere in life.\"")
        quotes.append("\"Comments are my main way to communicate with you bros.\"")
        quotes.append("\"Save the Children is an awesome charity that has helped more than 125 million children around the world, providing everything from school books to food to blankets and shelter.\"")
        quotes.append("\"I make funny videos of me playing video games, and I share those moments.\"")
        quotes.append("\"I just want to entertain; that is my main objective and what comes before everything else.\"")
        quotes.append("\"The thing that has made YouTube so successful is that you can relate to the people you're watching to a much higher degree than to the people you see on TV.\"")
        
        return quotes[Int(arc4random_uniform(9))]
        
    }
    
    func kanyeWestQuote() -> String {
        
        quotes = []
        
        quotes.append("\"You can’t look at a glass half full or empty if it’s overflowing.\"")
        quotes.append("\"I love Coldplay, and honestly think they are on the same level as the Beatles. In 30 years people will look back and say ‘these guys are more talented than the Beatles\"")
        quotes.append("\"I will be the leader of a company that ends up being worth billions of dollars, because I got the answers. I understand culture. I am the nucleus.\"")
        quotes.append("\"Don't ask me what I think the best song of last year was, because my opinion is the same as most of America's. It was Gold Digger.\"")
        quotes.append("\"No flip flops for black dudes. I don’t care where you at.\"")
        quotes.append("\"Like, I’m just giving up my body on the stage; I’m putting my life at risk, literally!\"")
        quotes.append("\"God chose me. He mad a path for me. I am God’s vessel.\"")
        quotes.append("\"They try to compromise my condom size. So I Snapchat that ho s**t.\"")
        quotes.append("\"Sometimes people write novels and they just be so wordy and so self-absorbed. I am not a fan of books. I would never want a book’s autograph.\"")
        quotes.append("\"I LIKE PORN!\"")
        
        return quotes[Int(arc4random_uniform(9))]
    }
    
    func kimKardashianQuote() -> String {
        
        quotes = []
        
        quotes.append("\"I’ll cry at the end of the day…not when I have fresh makeup on.\"")
        quotes.append("\"And they say I didn’t have a talent… try balancing a champagne glass on your ass… LOL!\"")
        quotes.append("\"I think it really takes about 15-20 selfies that someone takes on their phone before they post the right one.\"")
        quotes.append("\"I’m so mature now. I’m a grown-up version of myself.\"")
        quotes.append("\"I hate when women wear the wrong foundation color, it might be the worst thing on the planet when they wear their makeup too light.\"")
        quotes.append("\"See I do smile… even laugh on occasion…Not too often though because it causes wrinkles.\"")
        quotes.append("\"Leggings killed velour sweat suits! I used to only wear them until leggings came along.\"")
        quotes.append("\"It turned out beautifully, and I love it but I don't know if I'll pose nude again ... I'm too old for that now ... \"")
        quotes.append("\"I am Armenian, so of course I am obsessed with laser hair removal!\"")
        quotes.append("\"We met the Jonas Brothers. Nick [Jonas] is so cute ... I don't think Reggie will get mad because [Nick] is, like, 15. I really shouldn't say he's cute. It's a little inappropriate!\"")
        
        return quotes[Int(arc4random_uniform(9))]
    }
    
    func mileyCyrusQuote() -> String {
        
        quotes = []
        
        quotes.append("\"Haters are gonna hate, but haters are also going to click on your YouTube video just to watch it, so I don't really care.\"")
        quotes.append("\"Sex does sell, but you have to find a way that's not just showing your tits. \"")
        quotes.append("\"I've seen a lot of people spiral down with alcohol, but I've never seen that happen with weed.\"")
        quotes.append("\"In my mind I'm Gucci Mane, but on paper I'm a pop artist.\"")
        quotes.append("\"All of a sudden I woke up one day and went to Macy's and saw myself on a T-shirt. I feel empowered when I see my face on a T-shirt.'\"")
        quotes.append("\"I think that everyone should leave Twitter. I think Twitter should be banned from this universe.\"")
        quotes.append("\"I almost feel like people think of me as dumb...I'm like, I'm smarter than you think. You know, I understand what you're trying to do. It's all a mind game and whatnot.\"")
        quotes.append("\"I have a problem with people who wear board shorts when they're not going to the beach\"")
        quotes.append("\"I'm pretty cool. I'm pretty much the coolest person ever.\"")
        quotes.append("\"I listen to zero pop music, which is really weird from someone who makes pop music.\"")
        
        return quotes[Int(arc4random_uniform(9))]
    }
    
    func bernieSandersQuote() -> String {
        
        quotes = []
        
        quotes.append("\"We need a tax system which asks the billionaire class to pay its fair share of taxes which reduces the obscene degree of wealth inequality in America\"")
        quotes.append("\"Education should be a right, not a privilege. We need a revolution in the way that the United States funds higher education.\"")
        quotes.append("\"Social Security is a promise that we cannot and must not break. \"")
        quotes.append("\"As the rich become much richer, the level of income and wealth inequality has reached obscene and unimaginable levels.\"")
        quotes.append("\"We must transform our energy system away from fossil fuels and into energy efficiency and sustainable energies.\"")
        quotes.append("\"I have an ample supply of underwear.\"")
        
        return quotes[Int(arc4random_uniform(5))]
    }
    
    func jimmyFallonQuote() -> String {
        
        quotes = []
        
        quotes.append("\"The one thing you shouldn't do is try to tell a cab driver how to get somewhere.\"")
        quotes.append("\"Everyone looks so much better when they smile.\"")
        quotes.append("\"'Have fun' is my message. Be silly. You're allowed to be silly. There's nothing wrong with it.\"")
        quotes.append("\"Thank you, hard taco shells, for surviving the long journey from factory, to supermarket, to my plate and then breaking the moment I put something inside you. Thank you.\"")
        quotes.append("\"Thank you, people who say 'Wow, you're really photogenic,' for not saying what you really mean: 'Wow, you're really ugly in person.'\"")
        quotes.append("\"I'm going to North Pole to help out Santa this year.\"")
        quotes.append("\"Thank you... Apple, for adding a camera to the iPod Nano. Now it's just like the iPhone except it can't make calls. So basically, it's just like the iPhone.\"")
        quotes.append("\"Thank you... fantasy football draft, for letting me know that even in my fantasies, I am bad at sports.\"")
        quotes.append("\"Don't keep reaching for the stars because you'll just look like an idiot stretching that way for no reason.\"")
        quotes.append("\"Thank you... motion sensor hand towel machine. You never work, so I just end up looking like I'm waving hello to a wall robot.\"")
        
        return quotes[Int(arc4random_uniform(9))]
        
    }
    
}
