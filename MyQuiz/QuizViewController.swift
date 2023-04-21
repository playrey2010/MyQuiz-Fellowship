//
//  QuizViewController.swift
//  MyQuiz
//
//  Created by Mercedes Martinez Milantchi on 4/21/23.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    // create questions here
    let questions = [
            Question(text: "What is your favorite color?", answers: ["Red", "Blue", "Green", "Yellow"], correctAnswerIndex: 0),
            Question(text: "What is your favorite animal?", answers: ["Dog", "Cat", "Bird", "Fish"], correctAnswerIndex: 1),
            Question(text: "What is your favorite food?", answers: ["Pizza", "Sushi", "Tacos", "Burgers"], correctAnswerIndex: 2)
        ]
    
    var userAnswers: [Int] = []
    var currentQuestionIndex = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        questionLabel.text = questions[currentQuestionIndex].text
        answerTableView.dataSource = self
        answerTableView.delegate = self
        displayCurrentQuestion()
        answerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "answerCell")
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        calculateScore()
    }
    
    func displayCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
                questionLabel.text = currentQuestion.text
                userAnswers.append(-1)
                answerTableView.reloadData()
    }
    func calculateScore() {
            var score = 0
            for i in 0..<questions.count {
                if userAnswers[i] == questions[i].correctAnswerIndex {
                    score += 1
                }
            }
            let resultViewController = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
            resultViewController.score = score
            navigationController?.pushViewController(resultViewController, animated: true)
        }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
           cell.textLabel?.text = questions[currentQuestionIndex].answers[indexPath.row]
           if indexPath.row == userAnswers[currentQuestionIndex] {
               cell.accessoryType = .checkmark
           } else {
               cell.accessoryType = .none
           }
           return cell
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].answers.count
    }
}

extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            userAnswers[currentQuestionIndex] = indexPath.row
            answerTableView.reloadData()
        }
}
