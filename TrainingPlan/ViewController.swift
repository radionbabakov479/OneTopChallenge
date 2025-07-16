import SwiftUI

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "bgMain")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
                
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
    
    func openApp() {
        DispatchQueue.main.async {
            let view = ContentView()
            let hostingController = UIHostingController(rootView: view)
            self.setRootViewController(hostingController)
        }
    }

    
    func openPrivacyPolicy(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }

        let session = URLSession(configuration: .default, delegate: RedirectHandler { finalURL in
            DispatchQueue.main.async {
                if finalURL.contains("google") {
                    self.openApp()
                } else {
                    let webView = PrivacyPolicyViewController(url: stringURL)
                    self.setRootViewController(webView)
                }
            }
        }, delegateQueue: nil)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request).resume()
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
}


class RedirectHandler: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    private var redirectChain: [URL] = []
    private let completion: (String) -> Void

    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        if let url = request.url {
            redirectChain.append(url)
        }
        completionHandler(request)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        let finalURL = redirectChain.last?.absoluteString ?? task.originalRequest?.url?.absoluteString ?? ""
        completion(finalURL)
    }
}
