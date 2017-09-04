//
//  QuestionViewController.swift
//  Rio
//
//  Created by Nursultan on 8/6/16.
//  Copyright © 2016 Nursultan. All rights reserved.
//

import UIKit
import Neon
import Canvas

class QuestionViewController: UIViewController {
    
    lazy var timeLabel = UILabel()
    lazy var scoreLabel = UILabel()
    lazy var personImageView = UIImageView()
    lazy var button1 = UIButton()
    lazy var button2 = UIButton()
    lazy var button3 = UIButton()
    lazy var button4 = UIButton()
    lazy var resultView = CSAnimationView()
    lazy var scoreView = CSAnimationView()
    lazy var answerScoreLabel = UILabel()
    lazy var personView = CSAnimationView()
    
    var athleteNames = ["", "Абылайхан Жусупов", "Адильбек Ниязымбетов", "Александр Зайчиков", "Алексей Луценко", "Алмат Кебиспаев", "Арли Чонтей", "Артём Захаров", "Аслан Кахидзе", "Бахтияр Кожатаев", "Берик Абдрахманов", "Биржан Жакыпов", "Василий Левит", "Виталий Худяков", "Владимир Исаченко", "Владислав Яковлев", "Галымжан Усербаев", "Георгий Шейко", "Данияр Елеусинов", "Даулет Шабанбай", "Денис Уланов", "Дмитрий Баландин", "Досжан Картиков", "Елдос Сметов", "Жанибек Алимханулы", "Жансай Смагулов", "Иван Дычко", "Илья Мокрецов", "Кайрат Ералиев", "Кирилл Герасименко", "Максим Раков", "Мамед Ибрагимов", "Михаил Кукушкин", "Ниджат Рагимов", "Нурислам Санаев", "Нурмахан Тыналиев", "Олжас Саттыбаев", "Пирмаммад Алиев", "Рашид Юнусметов", "Руслан Жапаров", "Султан Дузелбаев", "Фархад Харки", "Юрий Юрков", "Александр Емельянов", "Алексей Дергунов", "Андрей Ергучёв", "Андрей Зейц", "Артас Санаа", "Дидар Хамза", "Дмитрий Коблов", "Евгений Алексеев", "Евгений Лабутов", "Иван Иванов", "Илья Голендов", "Михаил Красилов", "Павел Ильяшенко", "Роман Валиев", "Тимур Хайдаров", "Айнур Есбергенова", "Александра Немич Екатерина Немич", "Виктория Зябкина", "Галина Воскобоева", "Гюзель Манюрова", "Дарига Шакимова", "Екатерина Руденко", "Елизавета Король", "Жазира Жаппаркул", "Жайна Шекербекова", "Жансель Дениз", "Жулдыз Эшимова", "Карина Горичева", "Ларионова Екатерина", "Луиза Сайдиева", "Маргарита Елисеева", "Мариан Урдабаева", "Мария Дмитриенко", "Ольга Рыпакова", "Ольга Сафронова", "Отгонцэцэг Галбадрах", "Рима Кашафутдинова", "Сабина Аширбаева", "Светлана Германович", "Флорида Миниянова", "Эльмира Сыздыкова", "Юлия Путинцева", "Ярослава Шведова", "Александра Романова", "Анастасия Кудинова", "Анастасия Пилипенко", "Гульжанат Жанатбек", "Диана Айдосова", "Екатерина Смирнова", "Екатерина Эктова", "Елена Потапенко", "Зоя Ананченко", "Инна Клинова", "Ирина Литвиненко", "Ирина Смольникова", "Маргарита Мукашева", "Наталья Сергеева", "Светлана Голендова", "Элина Михина", "Юлия Рахманова"]
    
    var athleteIndex: Int = 0
    var athleteWrongIndex1: Int = 0
    var athleteWrongIndex2: Int = 0
    var athleteWrongIndex3: Int = 0
    
    var menCount = 57
    var womenCount = 45
    
    var timer = NSTimer()
    var timeCounter = 60
    
    let trueAnswerColor = UIColor(red: 4 / 255, green: 180 / 255, blue: 4 / 255, alpha: 1)
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QuestionViewController.timerAction), userInfo: nil, repeats: true)
        
        showQuestion()
    }
    
    func timerAction() {
        timeCounter = timeCounter - 1
        if timeCounter % 60 < 10 {
            timeLabel.text = "\(timeCounter / 60):0\(timeCounter % 60)"
        } else {
            timeLabel.text = "\(timeCounter / 60):\(timeCounter % 60)"
        }
        
        //timeLabel.text = String(timeCounter)
        
        if timeCounter <= 0 {
            
            timer.invalidate()
            let resultVC = ResultViewController()
            if score < 0 {
                score = 0
            }
            //resultVC.score = score
            //presentViewController(resultVC, animated: true, completion: nil)
            self.performSegueWithIdentifier("BackSegue", sender: nil)
        }
    }
    
    func initUI() {
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        imageViewBackground.image = UIImage(named: "background")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        timeLabel.textColor = .whiteColor()
        timeLabel.textAlignment = .Center
        timeLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        timeLabel.layer.cornerRadius = 10
        timeLabel.backgroundColor = .clearColor()
        
        scoreLabel.textColor = .whiteColor()
        scoreLabel.textAlignment = .Center
        scoreLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        scoreLabel.layer.cornerRadius = 10
        scoreLabel.backgroundColor = .clearColor()
        
        answerScoreLabel.textAlignment = .Center
        answerScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        answerScoreLabel.textAlignment = .Center
        
        
        resultView.backgroundColor = .clearColor()
        resultView.duration = 0.5;
        resultView.delay    = 0;
        resultView.type     = CSAnimationTypeZoomOut;

        scoreView.backgroundColor = .clearColor()
        scoreView.duration = 0.5
        scoreView.delay = 0
        
        
        personView.duration = 0.5
        personView.delay = 0
        //personView.type = CSAnimationTypeFadeIn
        
        resultView.addSubview(answerScoreLabel)
        scoreView.addSubview(scoreLabel)
        personView.addSubview(personImageView)
        view.addSubview(imageViewBackground)
        view.addSubview(scoreView)
        view.addSubview(resultView)
        view.addSubview(personView)
        view.addSubview(timeLabel)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button4.layer.borderWidth = 1
        
        button1.layer.cornerRadius = 5
        button2.layer.cornerRadius = 5
        button3.layer.cornerRadius = 5
        button4.layer.cornerRadius = 5
        
        button1.layer.borderColor = UIColor.whiteColor().CGColor
        button2.layer.borderColor = UIColor.whiteColor().CGColor
        button3.layer.borderColor = UIColor.whiteColor().CGColor
        button4.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        button1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button1.addTarget(self, action: #selector(QuestionViewController.button1Pressed), forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: #selector(QuestionViewController.button2Pressed), forControlEvents: .TouchUpInside)
        button3.addTarget(self, action: #selector(QuestionViewController.button3Pressed), forControlEvents: .TouchUpInside)
        button4.addTarget(self, action: #selector(QuestionViewController.button4Pressed), forControlEvents: .TouchUpInside)
        
        super.updateViewConstraints()
        
        resultView.anchorToEdge(.Top, padding: 30, width: 40, height: 50)
        timeLabel.anchorInCorner(.TopLeft, xPad: 10, yPad: 30, width: 60, height: 50)
        scoreView.anchorInCorner(.TopRight, xPad: 5, yPad: 30, width: 110, height: 50)
        personView.anchorToEdge(.Top, padding: 95, width: view.bounds.width * 0.75, height: view.bounds.width * 0.75)
        
        answerScoreLabel.fillSuperview()
        scoreLabel.fillSuperview()
        personImageView.fillSuperview()
    }
    
    func getWrongIndexes(n: Int, offset: Int) {
        athleteWrongIndex1 = offset + returnRandomNumber(n)
        
        while athleteWrongIndex1 == athleteIndex {
            athleteWrongIndex1 = offset + returnRandomNumber(n)
        }
        
        athleteWrongIndex2 = offset + returnRandomNumber(n)
        while athleteWrongIndex2 == athleteWrongIndex1 || athleteWrongIndex2 == athleteIndex {
            athleteWrongIndex2 = offset + returnRandomNumber(n)
        }
        
        athleteWrongIndex3 = offset + returnRandomNumber(n)
        while athleteWrongIndex3 == athleteWrongIndex1 || athleteWrongIndex3 == athleteWrongIndex2 || athleteWrongIndex3 == athleteIndex {
            athleteWrongIndex3 = offset + returnRandomNumber(n)
        }
    }
    
    func changeButtonTitles() {
        
            var indexes = [athleteIndex, athleteWrongIndex1, athleteWrongIndex2, athleteWrongIndex3]
        
            var counter = 0
            while counter < 24 {
                let i = returnRandomNumber(5) - 1
                let j = returnRandomNumber(5) - 1
                let d = indexes[i]
                indexes[i] = indexes[j]
                indexes[j] = d
                counter += 1
            }
        
            button1.setTitle(athleteNames[indexes[0]], forState: .Normal)
            button2.setTitle(athleteNames[indexes[1]], forState: .Normal)
            button3.setTitle(athleteNames[indexes[2]], forState: .Normal)
            button4.setTitle(athleteNames[indexes[3]], forState: .Normal)
        
        button1.tag = indexes[0]
        button2.tag = indexes[1]
        button3.tag = indexes[2]
        button4.tag = indexes[3]
        
        self.personImageView.layer.borderWidth = 2
        self.personImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.personImageView.image = UIImage(named: "\(athleteIndex)")
        
    }
    
    func showQuestion() {
        
        athleteIndex = returnRandomNumber(athleteNames.count)
        
        if athleteIndex < menCount {
            // Men
            getWrongIndexes(menCount, offset: 0)
        } else {
            //Women
            getWrongIndexes(womenCount, offset: menCount)
        }
        
        changeButtonTitles()
        
        var buttonBackgroundColor = UIColor(red: 252/255, green: 127 / 255, blue: 100 / 255, alpha: 1)
        
        //buttonBackgroundColor = UIColor(red: 217 / 255, green: 149 / 255, blue: 242 / 255, alpha: 1)
        
        button1.backgroundColor = buttonBackgroundColor
        button2.backgroundColor = buttonBackgroundColor
        button3.backgroundColor = buttonBackgroundColor
        button4.backgroundColor = buttonBackgroundColor
        
        if score < 0 {
            score = 0
        }
        scoreLabel.text = "Очки: \(score)"
    }
    
    func returnRandomNumber(n: Int) -> Int {
        let random = Int(arc4random_uniform(UInt32(n - 1)))
        return random + 1
    }
    
    func colorTrueQuestionButton() {
        if button1.tag == athleteIndex {
            button1.backgroundColor = trueAnswerColor
        } else
        if button2.tag == athleteIndex {
            button2.backgroundColor = trueAnswerColor
        } else
        if button3.tag == athleteIndex {
            button3.backgroundColor = trueAnswerColor
        } else {
            button4.backgroundColor = trueAnswerColor
        }
    }
    
    // MARK: - Actions
    
    func button1Pressed() {
        self.gameLogic(button1)
    }

    func button2Pressed() {
        self.gameLogic(button2)
    }
    
    func button3Pressed() {
        self.gameLogic(button3)    }
    
    func button4Pressed() {
        self.gameLogic(button4)
    }
    
    func gameLogic(sender: UIButton) {
        if sender.tag == athleteIndex {
            sender.backgroundColor = trueAnswerColor
            score = score + 3
            answerScoreLabel.textColor = trueAnswerColor
            answerScoreLabel.text = "+3"
        } else {
            sender.backgroundColor = .redColor()
            colorTrueQuestionButton()
            score = score - 2
            answerScoreLabel.textColor = .redColor()
            answerScoreLabel.text = "-2"
        }
        resultView.startCanvasAnimation()

        var gameTimer: NSTimer!
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(showQuestion), userInfo: nil, repeats: false)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackSegue" {
            let vc = segue.destinationViewController as! ResultViewController
            vc.score = score

        }
    }
}
