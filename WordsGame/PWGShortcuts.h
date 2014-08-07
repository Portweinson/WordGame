//
//  PWGShortcuts.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#ifndef WordsGame_PWGShortcuts_h
#define WordsGame_PWGShortcuts_h

#define APP_DELEGATE ((PWGAppDelegate *)[UIApplication sharedApplication].delegate)
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define DATA_MANAGER [PWGDataManager sharedInstance]
#define GAMES_MANAGER [PWGDataManager sharedInstance].gamesManager
#define WORDS_MANAGER [PWGDataManager sharedInstance].wordsManager
#define LANGUAGE_MANAGER [PWGDataManager sharedInstance].languageManager

#endif
