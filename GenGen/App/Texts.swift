//
//  Texts.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

struct Texts {
    // MARK: - Identifiers
    static let libraryTableViewCell = String(describing: LibraryTableViewCell.self)
    static let bookTableViewCell = String(describing: BookTableViewCell.self)
    static let rulesTableViewCell = String(describing: RulesTableViewCell.self)
    static let favoritesTableViewCell = String(describing: FavoritesTableViewCell.self)
    static let ruleCreatorTableViewCell = String(describing: RuleCreatorTableViewCell.self)
    static let onboardingCollectionViewCell = String(describing: OnboardingCollectionViewCell.self)

    // MARK: - Color Asset Names
    static let ggWhite = "ggWhite"
    static let ggLightGray = "ggLightGray"
    static let ggDarkGray = "ggDarkGray"
    static let ggGray = "ggGray"
    static let ggBlack = "ggBlack"
    static let ggPink = "ggPink"
    static let ggYellow = "ggYellow"
    static let ggLightYellow = "ggLightYellow"
    static let ggGreen = "ggGreen"
    static let ggLila = "ggLila"
    static let ggMint = "ggMint"
    static let ggOrange = "ggOrange"
    static let ggFixedLightGray = "ggFixedLightGray"
    static let ggOverlay = "ggOverlay"
    static let ggOpenAI = "ggOpenAI"
    static let ggRed = "ggRed"
    static let ggBlue = "ggBlue"
    static let ggPaleGreen = "ggPaleGreen"

    // MARK: - Image Asset Names
    static let logo = "logo"
    static let help = "help"
    static let magicWand = "magicWand"
    static let book = "book"
    static let add = "add"
    static let rules = "rules"
    static let favorites = "favorites"
    static let checkMark = "checkMark"
    static let pickUp = "pickUp"
    static let addFav = "addFav"
    static let close = "close"
    static let downloadGenGen = "downloadgengenonitunes"
    static let openAI = "openAI"

    // MARK: - Onboarding Image Asset Names
    static let onboarding1 = "onboarding1"
    static let onboarding2 = "onboarding2"
    static let onboarding3 = "onboarding3"
    static let onboarding4 = "onboarding4"
    static let onboarding5 = "onboarding5"
    static let onboarding6 = "onboarding6"
    static let onboarding7 = "onboarding7"

    // MARK: - Font Names
    static let arialRoundedMTBold = "ArialRoundedMTBold"
    static let futuraMedium = "Futura-Medium"

    // MARK: - TabBarItems
    static let generatorTabBarTitle = "Generator"
    static let libraryTabBarTitle = "Library"
    static let rulesTabBarTitle = "Rules"
    static let favoritesTabBarTitle = "Favorites"

    // MARK: - Navigation
    static let libraryNavigationTitle = "Library"
    static let rulesNavigationTitle = "Rules"
    static let favoritesNavigationTitle = "Favorites"
    static let ruleCreatorNavigationTitle = "New Rule"

    // MARK: - Generator
    static let generateButtonTitle = "Generate"

    // MARK: - Library
    static let addNewBookAlertTitle = "Enter a new book name"

    // MARK: - Book
    static let addNewWordAlertTitle = "Enter a word"

    // MARK: - Favorite
    static let addNewFavoriteAlertTitle = "Enter a custom text to your favorites"

    // MARK: - PromptAlert
    static let loadingTitle = "LOADING"
    static let promptAlertAddActionTitle = "Add"
    static let promptAlertCancelActionTitle = "Cancel"

    static let downloadGenGenText = """
        
        
        Sent from GenGen Custom Text Generator
        https://itunes.apple.com/us/app/gengen-custom-text-generator/id431167784?mt=8
        """

    // MARK: - GPT Types
    static let gptDefaultGenerateTitle = "Generate"
    static let gptAI2CentsTitle = "AI 2 cents"
    static let gptRhymeTitle = "Rhyme"
    static let gptJokeTitle = "Joke"
    static let gptMnemonicTitle = "Mnemonic"

    // MARK: - Data
    struct PrepopulationData {
        static let colors = [
            "amber", "beige", "black", "blue", "brown", "charcoal", "coral", "crimson", "cyan",
            "emerald", "gold", "green", "grey", "indigo", "ivory", "khaki", "lavender", "magenta",
            "maroon", "navy", "olive", "orange", "pink", "purple", "red", "silver", "tan", "teal",
            "violet", "white"
        ]

        static let sizes = [
            "ample", "atomic", "baby", "big", "bulky", "colossal", "enormous", "expanded", "full-size",
            "gargantuan", "giant", "grand", "great", "gross", "huge", "humongous", "immense", "jumbo",
            "king-size", "large", "little", "major", "massive", "mega", "micro", "minor", "petite",
            "small", "super", "teeny"
        ]

        static let animals = [
            "alligator", "ant", "antelope", "ape", "armadillo", "badger", "bat", "bear", "beaver", "bison",
            "buffalo", "camel", "caribou", "cat", "caterpillar", "chameleon", "cheetah", "chicken", "chimpanzee", "chinchilla",
            "chipmunk", "cobra", "cougar", "cow", "coyote", "crab", "crocodile", "crow", "deer", "dingo",
            "dog", "dolphin", "donkey", "dove", "dragonfly", "duck", "eagle", "eel", "elephant", "elk",
            "emu", "falcon", "ferret", "finch", "fish", "flamingo", "fox", "frog", "gazelle", "gecko",
            "giraffe", "goat", "goose", "gorilla", "grasshopper", "guinea pig", "hamster", "hawk", "hedgehog", "hippopotamus",
            "horse", "hyena", "iguana", "impala", "jaguar", "jellyfish", "kangaroo", "kiwi", "koala", "lemur",
            "leopard", "lion", "llama", "lobster", "lynx", "manatee", "mole", "monkey", "moose", "mouse",
            "narwhal", "newt", "octopus", "opossum", "orangutan", "orca", "ostrich", "otter", "owl", "ox",
            "panda", "panther", "parrot", "peacock", "pelican", "penguin", "pheasant", "pig", "pigeon", "porcupine",
            "possum", "puma", "quail", "rabbit", "raccoon", "rat", "raven", "reindeer", "rhino", "rooster"
        ]

        static let foods = [
            "baklava", "biscotti", "brownie", "burger", "burrito",
            "cheesecake", "churro", "croissant", "cupcake", "donut", "dumpling",
            "eclair", "falafel", "gelato", "gnocchi", "lasagna", "macaron",
            "macaroon", "miso", "moussaka", "muffin", "noodle", "paella",
            "pancake", "pizza", "ramen", "samosa", "stroopwafel", "sushi", "tiramisu"
        ]

        static let characteristics = [
            "adaptable", "adventurous", "ambitious", "amiable", "approachable",
            "articulate", "attentive", "awesome", "balanced", "benevolent", "brave", "calm",
            "caring", "charismatic", "charming", "cheerful", "compassionate", "confident",
            "considerate", "consistent", "cooperative", "courageous", "courteous", "creative",
            "curious", "decisive", "dedicated", "dependable", "determined", "diligent",
            "disciplined", "dynamic", "empathetic", "encouraging", "enthusiastic", "ethical",
            "fair", "faithful", "flexible", "friendly", "funky", "funny", "generous",
            "gentle", "genuine", "grateful", "hardworking", "helpful", "honest",
            "honorable", "hopeful", "humble", "humorous", "imaginative", "independent",
            "innovative", "insightful", "inspiring", "intelligent", "intuitive", "kind",
            "knowledgeable", "likable", "loyal", "mindful", "modest",
            "motivated", "nurturing", "observant", "optimistic", "organized", "passionate",
            "patient", "peaceful", "perceptive", "persistent", "playful", "polite",
            "positive", "practical", "principled", "proactive", "productive", "protective",
            "prudent", "reliable", "resilient", "resourceful", "respectful", "responsible",
            "selfless", "sincere", "smart", "sociable", "strong", "supportive", "sympathetic",
            "thoughtful", "trustworthy", "understanding", "versatile", "vibrant", "warm",
            "wise", "witty"
        ]

        static let actions = [
            "appreciating", "assisting", "building", "caring", "collaborating", "creating",
            "dancing", "discovering", "educating", "empathizing", "encouraging", "exploring",
            "forgiving", "gathering", "giving", "helping", "hugging", "imagining",
            "inspiring", "inventing", "jumping", "learning", "listening", "mentoring",
            "motivating", "nurturing", "organizing", "painting", "planting", "protecting",
            "reaching", "researching", "respecting", "sharing", "smiling", "solving",
            "supporting", "teaching", "thanking", "thinking", "training", "trusting",
            "uplifting", "volunteering", "welcoming", "writing"
        ]

        static let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

        static let capitals = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        static let lowercases = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        static let company = [
            "agency", "associates", "bureau", "collective", "consulting", "corporation",
            "creatives", "design", "digital", "enterprises", "entertainment", "factory",
            "group", "industries", "institute", "international", "labs", "limited",
            "media", "partners", "productions", "solutions", "squad", "startup",
            "studio", "team", "tech", "ventures", "works"
        ]

        static let persons = [
            "alien", "angel", "astronaut", "bard", "beast", "child",
            "cyborg", "dragon", "druid", "dwarf", "elf", "fae", "fairy", "friend",
            "giant", "goblin", "gnome", "hero", "human", "knight", "mage",
            "mermaid", "monster", "ninja", "orc", "robot", "samurai", "sorcerer",
            "villager", "warrior", "wizard", "witch", "zombie"
        ]

        static let things = [
            "anchor", "antique", "arrow", "bag", "balloon", "beacon", "bell", "blade",
            "block", "board", "book", "bottle", "brick", "brush", "bucket", "button",
            "cable", "camera", "can", "candle", "chain", "chip", "clock", "coin",
            "crystal", "cube", "cup", "disk", "drone", "feather", "filter", "flag",
            "flame", "flask", "fork", "gem", "gear", "globe", "grid", "handle",
            "hook", "horn", "hose", "key", "knot", "ladder", "lamp", "lever",
            "light", "lock", "magnet", "mask", "mirror", "motor", "net", "nut",
            "orb", "padlock", "panel", "pen", "pencil", "pixel", "plane", "plate",
            "plume", "pole", "pot", "potion", "propeller", "puzzle", "ribbon",
            "ring", "robot", "rope", "saber", "screw", "scroll", "sensor", "shield",
            "sign", "sphere", "spring", "star", "stone", "strap", "string", "switch",
            "tablet", "tile", "torch", "trap", "trophy", "tuner", "vase", "vent",
            "wand", "web", "wheel", "wire"
        ]

        static let places = [
            "alley", "arcade", "arena", "bakery",
            "bank", "bar", "beach", "bookstore", "bridge", "building", "cabin", "cafe",
            "castle", "cave", "city", "classroom", "clinic", "club", "conservatory",
            "courtyard", "desert", "dock", "dungeon", "factory", "farm",
            "field", "forest", "fortress", "fountain", "gallery", "garden", "gym", "hall", "harbor",
            "house", "hut", "inn", "island", "jungle",
            "lake", "lighthouse", "library", "lodge", "mall", "market",
            "mine", "mountain", "museum", "observatory", "office",
            "palace", "park", "playground", "plaza",
            "port", "pub", "restaurant", "riverbank",
            "school", "shop", "shrine", "space", "stadium", "station", "store", "street",
            "swamp", "theater", "tower", "town",
            "university", "valley", "village", "vineyard", "warehouse", "waterfall",
            "woods", "zoo"
        ]
    }
}
