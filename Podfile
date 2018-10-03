source 'https://github.com/cocoapods/specs.git'

platform :ios, '9.0'
use_frameworks!

######## Pods ########
## Data/Models
def alamofire;  pod 'Alamofire', '~> 4.7.3'; end
def promises;   pod 'PromisesSwift', '~> 1.2.3'; end
def swiftDate;  pod 'SwiftDate', '~> 4.0'; end

## Handlers
def errorhandler;   pod 'ErrorHandler', '~> 0.8.1'; end

## UI
def ibanimatable;   pod 'IBAnimatable', '~> 5.2.1'; end
def eureka;         pod 'Eureka', '~> 4.3.0'; end

######## Targets ########
target 'WallaMarvel' do
    ibanimatable
end

target 'WallaMarvelKit' do
    errorhandler
end

target 'WallaMarvelAPI' do
    alamofire
    promises
    swiftDate
end

target 'WallaMarvelUI' do
    ibanimatable
    promises
    eureka
end

######## Post-installation scripts ########
