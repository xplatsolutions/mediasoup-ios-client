//
//  Consumer.m
//  Project
//
//  Created by Denvir Ethan on 2019/11/22.
//  Copyright © 2019 Denvir Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Consumer.hpp"

@interface ConsumerWrapper : NSObject
@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) NSString *localId;
@property (nonatomic, readonly) NSString *producerId;
@property (nonatomic, readonly) NSObject *track;
@property (nonatomic, readonly) NSObject *rtpParameters;
@property (nonatomic, readonly) NSObject *appData;
@end

@interface ConsumerWrapper ()
@property (atomic, readonly, assign) mediasoupclient::Consumer *consumer;
@end

@implementation ConsumerWrapper
@synthesize consumer = _consumer;

// TODO: Constructor/Listener
-(id)init {
    self = [super init];
    if (self) {
        //_consumer = new mediasoupclient::Consumer();
    }
    return self;
}

-(NSString *)getNativeId {
    return [NSString stringWithUTF8String:self.consumer->GetId().c_str()];
}

-(NSString *)getNativeProducerId {
    return [NSString stringWithUTF8String:self.consumer->GetProducerId().c_str()];
}

-(Boolean *)isNativeClosed {
    return (Boolean *)self.consumer->IsClosed();
}

-(Boolean *)isNativePaused {
    return (Boolean *)self.consumer->IsPaused();
}

-(NSString *)getNativeKind {
    return [NSString stringWithUTF8String:self.consumer->GetKind().c_str()];
}

-(NSObject *)getNativeTrack {
    return (NSObject *)CFBridgingRelease(self.consumer->GetTrack());
}

-(NSString *)getNativeRtpParameters {
    const std::string rtpParametersString = self.consumer->GetRtpParameters().dump();
    return [NSString stringWithUTF8String:rtpParametersString.c_str()];
}

-(NSString *)getNativeAppData {
    const std::string appDataString = self.consumer->GetAppData().dump();
    return [NSString stringWithUTF8String:appDataString.c_str()];
}

-(void)nativeResume {
    self.consumer->Resume();
}

-(void)nativePause {
    self.consumer->Pause();
}

-(NSString *)getNativeStats {
    const std::string statsString = self.consumer->GetStats().dump();
    return [NSString stringWithUTF8String:statsString.c_str()];
}

-(void)nativeClose {
    self.consumer->Close();
}

@end