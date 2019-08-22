//
//  ThumbsWebVTTParser.hpp
//  CastlabsSDK
//
//  Created by Guido Parente on 30/01/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#ifndef ThumbsWebVTTParser_h
#define ThumbsWebVTTParser_h

#include <stdio.h>
#include <vector>
#include <string>

struct WebVTTThumb {
    uint64_t timestamp;
    uint64_t duration;
    std::string imageUrl;
    
    // Optional cordinates (x,y,width,heigth) of single thumb inside a master grid image
    std::vector<std::string> coordinates;
};

class ThumbsWebVTTParser {
public:
    std::vector<WebVTTThumb> parse(std::string str);
    uint64_t parseTimeMs(const std::string& timeExpression) const;
    std::string trim(std::string str);
};

#endif /* ThumbsWebVTTParser_hpp */
