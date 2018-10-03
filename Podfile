source 'https://github.com/cocoapods/specs.git'

platform :ios, '9.0'
use_frameworks!

######## Pods ########
## Data/Models
def alamofire;  pod 'Alamofire', '~> 4.7.3'; end
def promises;   pod 'PromisesSwift', '~> 1.2.3'; end
def swiftDate;  pod 'SwiftDate', '~> 4.0'; end

## UI
def ibanimatable; pod 'IBAnimatable', '~> 5.2.1'; end

######## Targets ########
target 'WallaMarvel' do
    ibanimatable
end

target 'WallaMarvelAPI' do
    alamofire
    promises
    swiftDate
end

######## Post-installation scripts ########
