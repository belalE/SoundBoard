//
//  ViewController.swift
//  SoundBoard
//
//  Created by mac pro on 7/22/17.
//  Copyright © 2017 Elsiesy Industries. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    
    var sounds : [Sound] = []
    var audioplayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TableView.dataSource = self
        TableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        do {
            audioplayer = try  AVAudioPlayer(data: sound.audio! as Data)
            audioplayer?.play()
            
        } catch {}
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            sounds = try context.fetch(Sound.fetchRequest())
            
            TableView.reloadData()
        } catch {}
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sound = sounds[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                sounds = try context.fetch(Sound.fetchRequest())
                
                TableView.reloadData()
            } catch {}
            
        }
    }
}

