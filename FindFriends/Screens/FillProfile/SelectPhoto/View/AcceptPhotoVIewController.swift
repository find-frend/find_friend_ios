import UIKit

final class AcceptPhotoVIewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.image = loadImage()
        view.backgroundColor = .systemBackground
        addView()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarView.image = loadImage()
    }
    weak var delegate: CustomUIPageControlProtocol?
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.text = "Фото профиля"
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Отлично! Все готово для поиска\n новых друзей"
        return label
    }()
    
    
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "plugPhoto")
        view.tintColor = .lightGray
        view.layer.frame.size.height = 171
        view.contentMode = .center
        view.layer.frame.size.width = view.layer.frame.size.height
        view.layer.cornerRadius = view.bounds.height / 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var continueButton: PrimeOrangeButton = {
        let button = PrimeOrangeButton(text: "Сохранить и продолжить")
        return button
    }()
    
    private lazy var cancelPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancelPhoto"), for: .normal)
        button.addTarget(self, action: #selector(didTapCancelPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private func loadImage() -> UIImage {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsURL.appendingPathComponent("avatar.png")
        continueButton.backgroundColor = .mainOrange
        avatarView.layer.borderWidth = 0
        guard fileManager.fileExists(atPath: imageUrl.path) else {
            continueButton.backgroundColor = .lightOrange
            continueButton.isEnabled = false 
            avatarView.layer.borderWidth = 4
            
            return UIImage(named: "plugPhoto")!
        }
        return UIImage(contentsOfFile: imageUrl.path)!
    }

    private func deleteImage() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsURL.appendingPathComponent("avatar.png")
        do {
            try fileManager.removeItem(at: imageUrl)
            print("Фотография успешно удалена")
        } catch {
            print("Ошибка удаления фотографии")
        }
    }
    
    private func addView() {
        [firstLabel, secondLabel, avatarView, continueButton, cancelPhotoButton].forEach(view.addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
            avatarView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 20),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: avatarView.frame.width),
            avatarView.heightAnchor.constraint(equalToConstant: avatarView.frame.height),
            cancelPhotoButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: -60),
            cancelPhotoButton.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor, constant: 60),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func didTapCancelPhotoButton() {
        deleteImage()
        delegate?.sendPage(number: 4)
    }
}
