//
//  UIColor+FPBrandColor.m
//  Category
//
//  Created by 杨晴贺 on 13/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIColor+FPBrandColor.h"


@implementation UIColor (FPBrandColor)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

+ (UIColor *)Fourormat
{
    return UIColorFromRGB(0xfb0a2a);
}

+ (UIColor *)FiveHundredPX
{
    return UIColorFromRGB(0x02adea);
}

+ (UIColor *)AboutMeBlue
{
    return UIColorFromRGB(0x00405d);
}

+ (UIColor *)AboutMeYellow
{
    return UIColorFromRGB(0xffcc33);
}

+ (UIColor *)Addvocate
{
    return UIColorFromRGB(0xff6138);
}

+ (UIColor *)Adobe
{
    return UIColorFromRGB(0xff0000);
}

+ (UIColor *)Aim
{
    return UIColorFromRGB(0xfcd20b);
}

+ (UIColor *)Amazon
{
    return UIColorFromRGB(0xe47911);
}

+ (UIColor *)Android
{
    return UIColorFromRGB(0xa4c639);
}

+ (UIColor *)Asana
{
    return UIColorFromRGB(0x1d8dd5);
}

+ (UIColor *)Atlassian
{
    return UIColorFromRGB(0x003366);
}

+ (UIColor *)Behance
{
    return UIColorFromRGB(0x005cff);
}

+ (UIColor *)bitly
{
    return UIColorFromRGB(0xee6123);
}

+ (UIColor *)Blogger
{
    return UIColorFromRGB(0xfc4f08);
}

+ (UIColor *)Carbonmade
{
    return UIColorFromRGB(0x613854);
}

+ (UIColor *)Cheddar
{
    return UIColorFromRGB(0xff7243);
}

+ (UIColor *)CocaCola
{
    return UIColorFromRGB(0xb50900);
}

+ (UIColor *)CodeSchool
{
    return UIColorFromRGB(0x3d4944);
}

+ (UIColor *)Delicious
{
    return UIColorFromRGB(0x205cc0);
}

+ (UIColor *)Dell
{
    return UIColorFromRGB(0x3287c1);
}

+ (UIColor *)Designmoo
{
    return UIColorFromRGB(0xe54a4f);
}

+ (UIColor *)Deviantart
{
    return UIColorFromRGB(0x4e6252);
}

+ (UIColor *)DesignerNews
{
    return UIColorFromRGB(0x2d72da);
}

+ (UIColor *)Dewalt
{
    return UIColorFromRGB(0xfebd17);
}

+ (UIColor *)DisqusBlue
{
    return UIColorFromRGB(0x59a3fc);
}
+ (UIColor *)DisqusOrange
{
    return UIColorFromRGB(0xdb7132);
}
+ (UIColor *)Dribbble
{
    return UIColorFromRGB(0xea4c89);
}

+ (UIColor *)Dropbox
{
    return UIColorFromRGB(0x3d9ae8);
}

+ (UIColor *)Drupal
{
    return UIColorFromRGB(0x0c76ab);
}

+ (UIColor *)Dunked
{
    return UIColorFromRGB(0x2a323a);
}

+ (UIColor *)eBay
{
    return UIColorFromRGB(0x89c507);
}

+ (UIColor *)Ember
{
    return UIColorFromRGB(0xf05e1b);
}

+ (UIColor *)Engadget
{
    return UIColorFromRGB(0x00bdf6);
}

+ (UIColor *)Envato
{
    return UIColorFromRGB(0x528036);
}

+ (UIColor *)Etsy
{
    return UIColorFromRGB(0xeb6d20);
}
+ (UIColor *)Evernote
{
    return UIColorFromRGB(0x5ba525);
}
+ (UIColor *)Fab
{
    return UIColorFromRGB(0xdd0017);
}
+ (UIColor *)Facebook
{
    return UIColorFromRGB(0x3b5998);
}
+ (UIColor *)Firefox
{
    return UIColorFromRGB(0xe66000);
}
+ (UIColor *)FlickrBlue
{
    return UIColorFromRGB(0x0063dc);
}
+ (UIColor *)FlickrPink
{
    return UIColorFromRGB(0xff0084);
}
+ (UIColor *)Forrst
{
    return UIColorFromRGB(0x5b9a68);
}
+ (UIColor *)Foursquare
{
    return UIColorFromRGB(0x25a0ca);
}
+ (UIColor *)Garmin
{
    return UIColorFromRGB(0x007cc3);
}
+ (UIColor *)GetGlue
{
    return UIColorFromRGB(0x2d75a2);
}
+ (UIColor *)Gimmebar
{
    return UIColorFromRGB(0xf70078);
}
+ (UIColor *)GitHub
{
    return UIColorFromRGB(0x171515);
}
+ (UIColor *)GoogleBlue
{
    return UIColorFromRGB(0x0140ca);
}
+ (UIColor *)GoogleGreen
{
    return UIColorFromRGB(0x16a61e);
}
+ (UIColor *)GoogleRed
{
    return UIColorFromRGB(0xdd1812);
}
+ (UIColor *)GoogleYellow
{
    return UIColorFromRGB(0xfcca03);
}
+ (UIColor *)GooglePlus
{
    return UIColorFromRGB(0xdd4b39);
}
+ (UIColor *)Grooveshark
{
    return UIColorFromRGB(0xf77f00);
}
+ (UIColor *) Groupon
{
    return UIColorFromRGB(0x82b548);
}
+ (UIColor *) HackerNews
{
    return UIColorFromRGB(0xff6600);
}
+ (UIColor *) HelloWallet
{
    return UIColorFromRGB(0x0085ca);
}
+ (UIColor *) HerokuLight
{
    return UIColorFromRGB(0xc7c5e6);
}
+ (UIColor *) HerokuDark
{
    return UIColorFromRGB(0x6567a5);
}
+ (UIColor *) HootSuite
{
    return UIColorFromRGB(0x003366);
}
+ (UIColor *) Houzz
{
    return UIColorFromRGB(0x73ba37);
}
+ (UIColor *) HP
{
    return UIColorFromRGB(0x0096d6);
}
+ (UIColor *) HTML5
{
    return UIColorFromRGB(0xec6231);
}
+ (UIColor *) Hulu
{
    return UIColorFromRGB(0x8cc83b);
}
+ (UIColor *) IBM
{
    return UIColorFromRGB(0x003e6a);
}
+ (UIColor *) IKEA
{
    return UIColorFromRGB(0xffcc33);
}
+ (UIColor *) IMDb
{
    return UIColorFromRGB(0xf3ce13);
}
+ (UIColor *) Instagram
{
    return UIColorFromRGB(0x3f729b);
}
+ (UIColor *) Instapaper
{
    return UIColorFromRGB(0x1c1c1c);
}
+ (UIColor *) Intel
{
    return UIColorFromRGB(0x0071c5);
}
+ (UIColor *) Intuit
{
    return UIColorFromRGB(0x365ebf);
}
+ (UIColor *) Kickstarter
{
    return UIColorFromRGB(0x76cc1e);
}
+ (UIColor *) kippt
{
    return UIColorFromRGB(0xe03500);
}
+ (UIColor *) Kodery
{
    return UIColorFromRGB(0x00af81);
}
+ (UIColor *) LastFM
{
    return UIColorFromRGB(0xc3000d);
}
+ (UIColor *) LinkedIn
{
    return UIColorFromRGB(0x0e76a8);
}
+ (UIColor *) Livestream
{
    return UIColorFromRGB(0xcf0005);
}
+ (UIColor *) Lumo
{
    return UIColorFromRGB(0x576396);
}
+ (UIColor *) MakitaRed
{
    return UIColorFromRGB(0xd82028);
}
+ (UIColor *) MakitaBlue
{
    return UIColorFromRGB(0x29a0b7);
}
+ (UIColor *) Mixpanel
{
    return UIColorFromRGB(0xa086d3);
}
+ (UIColor *) Meetup
{
    return UIColorFromRGB(0xe51937);
}
+ (UIColor *) Netflix
{
    return UIColorFromRGB(0xb9070a);
}
+ (UIColor *) Nokia
{
    return UIColorFromRGB(0x183693);
}
+ (UIColor *) NVIDIA
{
    return UIColorFromRGB(0x76b900);
}
+ (UIColor *) Odnoklassniki
{
    return UIColorFromRGB(0xed812b);
}
+ (UIColor *) Opera
{
    return UIColorFromRGB(0xcc0f16);
}
+ (UIColor *) Path
{
    return UIColorFromRGB(0xe41f11);
}
+ (UIColor *) PayPalDark
{
    return UIColorFromRGB(0x1e477a);
}
+ (UIColor *) PayPalLight
{
    return UIColorFromRGB(0x3b7bbf);
}
+ (UIColor *) Pinboard
{
    return UIColorFromRGB(0x0000e6);
}
+ (UIColor *) Pinterest
{
    return UIColorFromRGB(0xc8232c);
}
+ (UIColor *) PlayStation
{
    return UIColorFromRGB(0x665cbe);
}
+ (UIColor *) Pocket
{
    return UIColorFromRGB(0xee4056);
}
+ (UIColor *) Prezi
{
    return UIColorFromRGB(0x318bff);
}
+ (UIColor *) Pusha
{
    return UIColorFromRGB(0x0f71b4);
}
+ (UIColor *) Quora
{
    return UIColorFromRGB(0xa82400);
}
+ (UIColor *) QuoteFm
{
    return UIColorFromRGB(0x66ceff);
}
+ (UIColor *) Rdio
{
    return UIColorFromRGB(0x008fd5);
}
+ (UIColor *) Readability
{
    return UIColorFromRGB(0x9c0000);
}
+ (UIColor *) RedHat
{
    return UIColorFromRGB(0xcc0000);
}
+ (UIColor *) RedditBlue
{
    return UIColorFromRGB(0xcee2f8);
}
+ (UIColor *) RedditOrange
{
    return UIColorFromRGB(0xff4500);
}
+ (UIColor *) Resource
{
    return UIColorFromRGB(0x7eb400);
}
+ (UIColor *) Rockpack
{
    return UIColorFromRGB(0x0ba6ab);
}
+ (UIColor *) Roon
{
    return UIColorFromRGB(0x62b0d9);
}
+ (UIColor *) RSS
{
    return UIColorFromRGB(0xee802f);
}
+ (UIColor *) Salesforce
{
    return UIColorFromRGB(0x1798c1);
}
+ (UIColor *) Samsung
{
    return UIColorFromRGB(0x0c4da2);
}
+ (UIColor *) Shopify
{
    return UIColorFromRGB(0x96bf48);
}
+ (UIColor *) Skype
{
    return UIColorFromRGB(0x00aff0);
}
+ (UIColor *) SmashingMagazine
{
    return UIColorFromRGB(0xf0503a);
}
+ (UIColor *) Snagajob
{
    return UIColorFromRGB(0xf47a20);
}
+ (UIColor *) Softonic
{
    return UIColorFromRGB(0x008ace);
}
+ (UIColor *) SoundCloud
{
    return UIColorFromRGB(0xff7700);
}
+ (UIColor *) SpaceBox
{
    return UIColorFromRGB(0xf86960);
}
+ (UIColor *) Spotify
{
    return UIColorFromRGB(0x81b71a);
}
+ (UIColor *) Sprint
{
    return UIColorFromRGB(0xfee100);
}
+ (UIColor *) Squarespace
{
    return UIColorFromRGB(0x121212);
}
+ (UIColor *) StackOverflow
{
    return UIColorFromRGB(0xef8236);
}
+ (UIColor *) Staples
{
    return UIColorFromRGB(0xcc0000);
}
+ (UIColor *) StatusChart
{
    return UIColorFromRGB(0xd7584f);
}
+ (UIColor *) Stripe
{
    return UIColorFromRGB(0x008cdd);
}
+ (UIColor *) StudyBlue
{
    return UIColorFromRGB(0x00afe1);
}
+ (UIColor *) StumbleUpon
{
    return UIColorFromRGB(0xf74425);
}
+ (UIColor *) TMobile
{
    return UIColorFromRGB(0xea0a8e);
}
+ (UIColor *) Technorati
{
    return UIColorFromRGB(0x40a800);
}
+ (UIColor *) TheNextWeb
{
    return UIColorFromRGB(0xef4423);
}
+ (UIColor *) Treehouse
{
    return UIColorFromRGB(0x5cb868);
}
+ (UIColor *) Trello
{
    return UIColorFromRGB(0x256a92);
}
+ (UIColor *) Trulia
{
    return UIColorFromRGB(0x5eab1f);
}
+ (UIColor *) Tumblr
{
    return UIColorFromRGB(0x34526f);
}
+ (UIColor *) TwitchTv
{
    return UIColorFromRGB(0x6441a5);
}
+ (UIColor *) Twitter
{
    return UIColorFromRGB(0x00acee);
}
+ (UIColor *) Typekit
{
    return UIColorFromRGB(0x9aca3c);
}
+ (UIColor *) TYPO3
{
    return UIColorFromRGB(0xff8700);
}
+ (UIColor *) Ubuntu
{
    return UIColorFromRGB(0xdd4814);
}
+ (UIColor *) Ustream
{
    return UIColorFromRGB(0x3388ff);
}
+ (UIColor *) Verizon
{
    return UIColorFromRGB(0xef1d1d);
}
+ (UIColor *) Vimeo
{
    return UIColorFromRGB(0x44bbff);
}
+ (UIColor *) Vine
{
    return UIColorFromRGB(0x00a478);
}
+ (UIColor *) Virb
{
    return UIColorFromRGB(0x06afd8);
}
+ (UIColor *) VirginMedia
{
    return UIColorFromRGB(0xcc0000);
}
+ (UIColor *) VKontakte
{
    return UIColorFromRGB(0x45668e);
}
+ (UIColor *) Wooga
{
    return UIColorFromRGB(0x5b009c);
}
+ (UIColor *) WordPressBlue
{
    return UIColorFromRGB(0x21759b);
}
+ (UIColor *) WordPressOrange
{
    return UIColorFromRGB(0xd54e21);
}
+ (UIColor *) WordPressGrey
{
    return UIColorFromRGB(0x464646);
}
+ (UIColor *) Wunderlist
{
    return UIColorFromRGB(0x2b88d9);
}
+ (UIColor *) XBOX
{
    return UIColorFromRGB(0x9bc848);
}
+ (UIColor *) XING
{
    return UIColorFromRGB(0x126567);
}
+ (UIColor *) Yahoo
{
    return UIColorFromRGB(0x720e9e);
}
+ (UIColor *) Yandex
{
    return UIColorFromRGB(0xffcc00);
}
+ (UIColor *) Yelp
{
    return UIColorFromRGB(0xc41200);
}
+ (UIColor *) YouTube
{
    return UIColorFromRGB(0xc4302b);
}
+ (UIColor *) Zalongo
{
    return UIColorFromRGB(0x5498dc);
}
+ (UIColor *) Zendesk
{
    return UIColorFromRGB(0x78a300);
}
+ (UIColor *) Zerply
{
    return UIColorFromRGB(0x9dcc7a);
}
+ (UIColor *) Zootool
{
    return UIColorFromRGB(0x5e8b1d);
}

@end
