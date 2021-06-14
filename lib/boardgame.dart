import 'dart:convert';

BoardGame boardGameFromJson(String str) => BoardGame.fromJson(json.decode(str));

String boardGameToJson(BoardGame data) => json.encode(data.toJson());

class BoardGame {
    List<Game> games;

    BoardGame({
        this.games,
    });

    factory BoardGame.fromJson(Map<String, dynamic> json) => new BoardGame(
        games: new List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "games": new List<dynamic>.from(games.map((x) => x.toJson())),
    };
}

class Game {
    String id;
    String name;
    int yearPublished;
    int minPlayers;
    int maxPlayers;
    int minPlaytime;
    int maxPlaytime;
    int minAge;
    String description;
    String descriptionPreview;
    String imageUrl;
    String thumbUrl;
    Images images;
    String url;
    String price;
    String msrp;
    String discount;
    String primaryPublisher;
    List<String> publishers;
    List<Category> mechanics;
    List<Category> categories;
    List<String> designers;
    List<dynamic> developers;
    List<String> artists;
    List<String> names;
    int numUserRatings;
    double averageUserRating;
    String officialUrl;
    String rulesUrl;
    double weightAmount;
    String weightUnits;
    double sizeHeight;
    double sizeWidth;
    int sizeDepth;
    String sizeUnits;
    dynamic matchesSpecs;
    List<Category> spec;
    int redditAllTimeCount;
    int redditWeekCount;
    int redditDayCount;
    double historicalLowPrice;
    HistoricalLowDate historicalLowDate;

    Game({
        this.id,
        this.name,
        this.yearPublished,
        this.minPlayers,
        this.maxPlayers,
        this.minPlaytime,
        this.maxPlaytime,
        this.minAge,
        this.description,
        this.descriptionPreview,
        this.imageUrl,
        this.thumbUrl,
        this.images,
        this.url,
        this.price,
        this.msrp,
        this.discount,
        this.primaryPublisher,
        this.publishers,
        this.mechanics,
        this.categories,
        this.designers,
        this.developers,
        this.artists,
        this.names,
        this.numUserRatings,
        this.averageUserRating,
        this.officialUrl,
        this.rulesUrl,
        this.weightAmount,
        this.weightUnits,
        this.sizeHeight,
        this.sizeWidth,
        this.sizeDepth,
        this.sizeUnits,
        this.matchesSpecs,
        this.spec,
        this.redditAllTimeCount,
        this.redditWeekCount,
        this.redditDayCount,
        this.historicalLowPrice,
        this.historicalLowDate,
    });

    factory Game.fromJson(Map<String, dynamic> json) => new Game(
        id: json["id"],
        name: json["name"],
        yearPublished: json["year_published"] == null ? null : json["year_published"],
        minPlayers: json["min_players"] == null ? null : json["min_players"],
        maxPlayers: json["max_players"] == null ? null : json["max_players"],
        minPlaytime: json["min_playtime"] == null ? null : json["min_playtime"],
        maxPlaytime: json["max_playtime"] == null ? null : json["max_playtime"],
        minAge: json["min_age"] == null ? null : json["min_age"],
        description: json["description"],
        descriptionPreview: json["description_preview"],
        imageUrl: json["image_url"],
        thumbUrl: json["thumb_url"],
        images: Images.fromJson(json["images"]),
        url: json["url"],
        price: json["price"],
        msrp: json["msrp"],
        discount: json["discount"],
        primaryPublisher: json["primary_publisher"] == null ? null : json["primary_publisher"],
        publishers: new List<String>.from(json["publishers"].map((x) => x)),
        mechanics: new List<Category>.from(json["mechanics"].map((x) => Category.fromJson(x))),
        categories: new List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        designers: new List<String>.from(json["designers"].map((x) => x)),
        developers: new List<dynamic>.from(json["developers"].map((x) => x)),
        artists: new List<String>.from(json["artists"].map((x) => x)),
        names: new List<String>.from(json["names"].map((x) => x)),
        numUserRatings: json["num_user_ratings"],
        averageUserRating: json["average_user_rating"] == null ? null : json["average_user_rating"].toDouble(),
        officialUrl: json["official_url"] == null ? null : json["official_url"],
        rulesUrl: json["rules_url"] == null ? null : json["rules_url"],
        weightAmount: json["weight_amount"] == null ? null : json["weight_amount"],
        weightUnits: json["weight_units"] == null ? null : json["weight_units"],
        sizeHeight: json["size_height"] == null ? null : json["size_height"].toDouble(),
        sizeWidth: json["size_width"] == null ? null : json["size_width"].toDouble(),
        sizeDepth: json["size_depth"] == null ? null : json["size_depth"],
        sizeUnits: json["size_units"] == null ? null : json["size_units"],
        matchesSpecs: json["matches_specs"],
        spec: new List<Category>.from(json["spec"].map((x) => Category.fromJson(x))),
        redditAllTimeCount: json["reddit_all_time_count"],
        redditWeekCount: json["reddit_week_count"],
        redditDayCount: json["reddit_day_count"],
        historicalLowPrice: json["historical_low_price"] == null ? null : json["historical_low_price"].toDouble(),
        historicalLowDate: json["historical_low_date"] == null ? null : HistoricalLowDate.fromJson(json["historical_low_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year_published": yearPublished == null ? null : yearPublished,
        "min_players": minPlayers == null ? null : minPlayers,
        "max_players": maxPlayers == null ? null : maxPlayers,
        "min_playtime": minPlaytime == null ? null : minPlaytime,
        "max_playtime": maxPlaytime == null ? null : maxPlaytime,
        "min_age": minAge == null ? null : minAge,
        "description": description,
        "description_preview": descriptionPreview,
        "image_url": imageUrl,
        "thumb_url": thumbUrl,
        "images": images.toJson(),
        "url": url,
        "price": price,
        "msrp": msrp,
        "discount": discount,
        "primary_publisher": primaryPublisher == null ? null : primaryPublisher,
        "publishers": new List<dynamic>.from(publishers.map((x) => x)),
        "mechanics": new List<dynamic>.from(mechanics.map((x) => x.toJson())),
        "categories": new List<dynamic>.from(categories.map((x) => x.toJson())),
        "designers": new List<dynamic>.from(designers.map((x) => x)),
        "developers": new List<dynamic>.from(developers.map((x) => x)),
        "artists": new List<dynamic>.from(artists.map((x) => x)),
        "names": new List<dynamic>.from(names.map((x) => x)),
        "num_user_ratings": numUserRatings,
        "average_user_rating": averageUserRating == null ? null : averageUserRating,
        "official_url": officialUrl == null ? null : officialUrl,
        "rules_url": rulesUrl == null ? null : rulesUrl,
        "weight_amount": weightAmount == null ? null : weightAmount,
        "weight_units": weightUnits == null ? null : weightUnits,
        "size_height": sizeHeight == null ? null : sizeHeight,
        "size_width": sizeWidth == null ? null : sizeWidth,
        "size_depth": sizeDepth == null ? null : sizeDepth,
        "size_units": sizeUnits == null ? null : sizeUnits,
        "matches_specs": matchesSpecs,
        "spec": new List<dynamic>.from(spec.map((x) => x.toJson())),
        "reddit_all_time_count": redditAllTimeCount,
        "reddit_week_count": redditWeekCount,
        "reddit_day_count": redditDayCount,
        "historical_low_price": historicalLowPrice == null ? null : historicalLowPrice,
        "historical_low_date": historicalLowDate == null ? null : historicalLowDate.toJson(),
    };
}

class Category {
    String id;

    Category({
        this.id,
    });

    factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class HistoricalLowDate {
    DateTime date;

    HistoricalLowDate({
        this.date,
    });

    factory HistoricalLowDate.fromJson(Map<String, dynamic> json) => new HistoricalLowDate(
        date: DateTime.parse(json["\u0024date"]),
    );

    Map<String, dynamic> toJson() => {
        "\u0024date": date.toIso8601String(),
    };
}

class Images {
    String thumb;
    String small;
    String medium;
    String large;
    String original;

    Images({
        this.thumb,
        this.small,
        this.medium,
        this.large,
        this.original,
    });

    factory Images.fromJson(Map<String, dynamic> json) => new Images(
        thumb: json["thumb"],
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
        original: json["original"],
    );

    Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "small": small,
        "medium": medium,
        "large": large,
        "original": original,
    };
}
