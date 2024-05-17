extends CharacterBody2D
class_name SaveLoadGame

var m_File : FileAccess		# File object opened by the FileAccess library
var m_FilePath : String		# File path to the requested file
var m_Password : String		# Password for file encryption and decryption

# Fill the file data in the local variables
func Initialize(path : String, password : String) -> void:
	m_FilePath = path
	m_Password = password

# Clear the file data in the local variables
func Clear() -> void:
	m_File = null
	m_FilePath = ""
	m_Password = ""

# Open a file encrypted with the given password
func OpenFile(access : FileAccess.ModeFlags) -> int:
	
	# Try opening an encrypted file with write access
	m_File = FileAccess.open_encrypted_with_pass(m_FilePath, access, m_Password)
	
	# Return the assigned file index (handle)
	return FileAccess.get_open_error() if (m_File == null) else OK
	
# Open a file encrypted with the given password
func CloseFile() -> void:
	m_File = null

# Serialize the object's properties and write them to the file with the given ID
func Serialize(object) -> void:
	object.Serialize(m_File)
	
# Read the object's properties from the given file and deserialize them
func Deserialize(object) -> void:
	object.Deserialize(m_File)
