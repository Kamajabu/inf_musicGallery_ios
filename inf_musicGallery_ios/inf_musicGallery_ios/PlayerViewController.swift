

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    


    var imageIndex: IndexPath?
    var musicItems: [MusicItem] = []

    var trackId: Int = 0
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self


        songTitleLabel.text = musicItems[trackId].title
        artistLabel.text = musicItems[trackId].artist
        
        let path = Bundle.main.path(forResource: "\(musicItems[trackId].fileName)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }



        
    }

    override func viewDidLayoutSubviews() {
        self.collectionView?.scrollToItem(at: imageIndex!, at: .centeredHorizontally, animated: false)
        self.collectionView.reloadData()

    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    func updateProgressView(){
        
        if audioPlayer.isPlaying {
            
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }

    @IBAction func playAction(_ sender: AnyObject) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        
    }

    @IBAction func stopAction(_ sender: AnyObject) {
    
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    
    
    @IBAction func pauseAction(_ sender: AnyObject) {
    audioPlayer.pause()
    }
    
    @IBAction func fastForwardAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0
        
        if time > audioPlayer.duration {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
        
    }
    
    @IBAction func rewindAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0
        
        if time < 0 {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    
   
    @IBAction func previousAction(_ sender: AnyObject) {
        if trackId != 0 || trackId > 0 {
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
            }else {
                trackId -= 1
            }
            
//            if let coverImage = library[trackId]["coverImage"]{
//                coverImageView.image = UIImage(named: "\(coverImage).jpg")
//            }


//

            self.collectionView?.scrollToItem(at: IndexPath(item: trackId, section: 0),
                                              at: .centeredHorizontally, animated: true)

            songTitleLabel.text = musicItems[trackId].title
            artistLabel.text = musicItems[trackId].artist
            
            audioPlayer.currentTime = 0
            progressView.progress = 0
            
            let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = URL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                    audioPlayer.play()
                    
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func nextAction(_ sender: AnyObject) {
   
        if trackId == 0 || trackId < musicItems.count {
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(musicItems.count)))
            }else {
                trackId += 1
            }
            
//            if let coverImage = library[trackId]["coverImage"]{
//                coverImageView.image = UIImage(named: "\(coverImage).jpg")
//            }
//

            self.collectionView?.scrollToItem(at: IndexPath(item: trackId, section: 0),
                                              at: .centeredHorizontally, animated: true)

            songTitleLabel.text = musicItems[trackId].title
            artistLabel.text = musicItems[trackId].artist
            
            audioPlayer.currentTime = 0
            progressView.progress = 0

            //fix
            let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = URL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                    audioPlayer.play()
                    
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
       
    }
    
    
    
    
}
