import UIKit

final class SelectPhotoViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.image = UIImage(named: "plugPhoto")
        view.backgroundColor = .systemBackground
        addView()
        applyConstraints()
    }
    
    weak var delegate: CustomUIPageControlProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarView.image = UIImage(named: "plugPhoto")
        avatarView.layer.borderWidth = 4
    }
    
    private func loadImage() -> UIImage {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsURL.appendingPathComponent("avatar.png")
        avatarView.layer.borderWidth = 0
        continueButton.isEnabled = true
        continueButton.backgroundColor = .mainOrange
        guard fileManager.fileExists(atPath: imageUrl.path) else {
            avatarView.layer.borderWidth = 4
            continueButton.isEnabled = false
            continueButton.backgroundColor = .lightOrange
            return UIImage(named: "plugPhoto")!
        }
        return UIImage(contentsOfFile: imageUrl.path)!
    }
    
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
        label.text = "Добавьте фото, чтобы другим было\n проще вас узнать"
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
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setImage(UIImage(named: "addPhoto"), for: .normal)
        button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: PrimeOrangeButton = {
        let button = PrimeOrangeButton(text: "Сохранить и продолжить")
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private func addView() {
        [firstLabel, secondLabel, avatarView, addPhotoButton, continueButton, skipButton].forEach(view.addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
            avatarView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 20),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: avatarView.frame.width),
            avatarView.heightAnchor.constraint(equalToConstant: avatarView.frame.height),
            addPhotoButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -25),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func profileImageButtonTapped() {
        showImagePickerControleActionSheet()
    }
    
    @objc private func didTapContinueButton() {
        let vc = AcceptPhotoVIewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SelectPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControleActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.choosePicker(sourceType: .camera)
            } else {print("Камера недоступна") }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { (action:UIAlertAction) in
            self.choosePicker(sourceType: .photoLibrary)}))
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    func choosePicker(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        UINavigationBar.appearance().backgroundColor = .white
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            saveImage(editedImage)
            avatarView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarView.image = originalImage
            saveImage(originalImage)
        }
        avatarView.layer.borderWidth = 0
        dismiss(animated: true, completion: nil)
    }
    
    func saveImage(_ image: UIImage) {
        guard let data = image.pngData() else { return }
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsURL.appendingPathComponent("avatar.png")
        do {
            try data.write(to: imageUrl)
            continueButton.isEnabled = true
            continueButton.backgroundColor = .mainOrange
        } catch {
            continueButton.isEnabled = false
            continueButton.backgroundColor = .lightOrange
            print("Ошибка сохранения изображения")
        }
    }
    
}


