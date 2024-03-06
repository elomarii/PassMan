# PassMan - Password Manager
PassMan is a password management application designed to securely store and manage passwords. It employs robust encryption techniques to ensure the safety of your sensitive information.

### Dependencies
- Data Base Management System: [sqflite](https://pub.dev/packages/sqflite).
- Cryptography: [cryptography](https://pub.dev/packages/cryptography)

### High-level description of how it works

When a user enters the passphrase, its hash is compared to a pre-stored hash to authenticate the user.
The passphrase is temporarily stored to be provided as a key for the decryption algorithm.
This ensures that only authorized users can access the stored passwords.

PassMan employs AES-256 encryption in GCM (Galois/Counter Mode) to encrypt and protect user data.
This encryption scheme is widely recognized for its strength and security, providing robust protection for stored passwords and information.

### Currently working on
- [ ] Import/export encryption files

---

**Note**: PassMan is a personal project for educational and demonstration purposes only.
It is not intended for use in production environments where stringent security measures are required.
Use at your own risk.



