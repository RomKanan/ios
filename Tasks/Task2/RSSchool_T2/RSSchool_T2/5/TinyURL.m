#import "TinyURL.h"

@interface TinyURL ()

@property (nonatomic, retain) NSMutableDictionary* keys;
@property (nonatomic, retain) NSString* path;

@end

@implementation TinyURL

- (NSURL *)encode:(NSURL *)originalURL
{
    NSString* longUrlStr = [originalURL absoluteString];
    
    NSMutableString *shortUrlStr = [NSMutableString stringWithFormat:@"https://rk.cc/A%ldB", self.keys.count];
    
    [[self keys] setObject:longUrlStr forKey:shortUrlStr];
    
    NSURL* shortUrl = [NSURL URLWithString:shortUrlStr];
    return shortUrl;
}

- (NSURL *)decode:(NSURL *)shortenedURL
{
    NSString* shortUrlStr = [shortenedURL absoluteString];
    
    NSString* longUrlStr = [self.keys objectForKey:shortUrlStr];
    
    NSURL* longUrl = [NSURL URLWithString:longUrlStr];
    return longUrl;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths firstObject];
        self.path = [documentsDirectory stringByAppendingPathComponent:@"keysDict.plist"];
        self.keys = [NSMutableDictionary dictionaryWithContentsOfFile:self.path];
        if(!self.keys)
        {
            self.keys = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

- (void)dealloc
{
    [_keys writeToFile:_path atomically:YES];
    [_path release];
    [_keys release];
    [super dealloc];
}

@end
