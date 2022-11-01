//
//  FoodDetailsView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class FoodDetailsView: UIView {
    var data: [CellsInfoSections] = [
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
    ]
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 100, height: 200)
        layout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.decelerationRate = .fast
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        
        return collection
    }()
    
    lazy var youMayLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You may also like"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mac-and-cheese")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var topFadedLabel: UIButton = {
        let view = NextScreenGreenButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var purpheHearthView: purpleHearth = {
        let view = purpleHearth()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeView: TimerView = {
        let timer = TimerView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    lazy var pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250/255, green: 236/255, blue: 255/255, alpha: 1)
        return view
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detalhes"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var firstPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Proteins", numberText: "25")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Fat", numberText: "81")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thirdPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Calories", numberText: "105")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var forthPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Carb", numberText: "53")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var prepareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients:"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        • Pasta
        1 cup of wheat flour
        1 beaten yolk
        100 grams of unsalted butter
        2 tablespoons of sugar
        1 tablespoon of baking powder

        • Filling
        700 milliliters of milk
        """
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        contentView.addSubview(foodImageView)
        contentView.addSubview(topFadedLabel)
        contentView.addSubview(purpheHearthView)
        contentView.addSubview(timeView)
        contentView.addSubview(pinkView)
        contentView.addSubview(detailLabel)
        contentView.addSubview(firstPurpleContainer)
        contentView.addSubview(secondPurpleContainer)
        contentView.addSubview(thirdPurpleContainer)
        contentView.addSubview(forthPurpleContainer)
        contentView.addSubview(prepareLabel)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(youMayLikeLabel)
        contentView.addSubview(collectionView)
        setupCollectionView()
        configConstraints()
        
        self.backgroundColor = .viewBackgroundColor
        
    }
    
    func setupCollectionView() {
        collectionView.register(FoodDetailsCollectionViewCell.nib(), forCellWithReuseIdentifier: FoodDetailsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Constraints
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 320),
            
            topFadedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            topFadedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            purpheHearthView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            purpheHearthView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 50),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 50),
            
            timeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 290),
            timeView.leadingAnchor.constraint(equalTo: topFadedLabel.leadingAnchor),
            timeView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: -20),
            
            pinkView.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 1),
            pinkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pinkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pinkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            detailLabel.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 5),
            detailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            firstPurpleContainer.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 60),
            firstPurpleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            secondPurpleContainer.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 60),
            secondPurpleContainer.leadingAnchor.constraint(equalTo: firstPurpleContainer.trailingAnchor, constant: 5),
            
            thirdPurpleContainer.topAnchor.constraint(equalTo: firstPurpleContainer.bottomAnchor, constant: 10),
            thirdPurpleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            forthPurpleContainer.topAnchor.constraint(equalTo: secondPurpleContainer.bottomAnchor, constant: 10),
            forthPurpleContainer.leadingAnchor.constraint(equalTo: thirdPurpleContainer.trailingAnchor, constant: 5),
            
            prepareLabel.topAnchor.constraint(equalTo: thirdPurpleContainer.bottomAnchor, constant: 25),
            prepareLabel.leadingAnchor.constraint(equalTo: firstPurpleContainer.leadingAnchor),
            
            instructionsLabel.topAnchor.constraint(equalTo: prepareLabel.bottomAnchor,constant: 8),
            instructionsLabel.leadingAnchor.constraint(equalTo: prepareLabel.leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: secondPurpleContainer.trailingAnchor),

            // todo: add bottom
            youMayLikeLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor,constant: 12),
            youMayLikeLabel.leadingAnchor.constraint(equalTo: instructionsLabel.leadingAnchor),
            youMayLikeLabel.trailingAnchor.constraint(equalTo: instructionsLabel.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: youMayLikeLabel.bottomAnchor,constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: youMayLikeLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: youMayLikeLabel.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension FoodDetailsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodDetailsCollectionViewCell.identifier, for: indexPath) as! FoodDetailsCollectionViewCell
        cell.setup(data[indexPath.row])
        return cell
    }
}
