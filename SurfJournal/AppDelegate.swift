/*
* Copyright (c) 2016 Hector Otero (aka John Ramirez)
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var coreDataStack = CoreDataStack()

  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [NSObject : AnyObject]?) -> Bool {
    
    let navigationController = window!.rootViewController
      as! UINavigationController
    let listViewController =
        navigationController.topViewController
          as! JournalListViewController
    listViewController.coreDataStack = coreDataStack
      
    UIViewController.prepareInterstitialAds()

    return true
  }

  func applicationWillTerminate(application: UIApplication) {
    coreDataStack.saveContext()
  }
  
 
}

