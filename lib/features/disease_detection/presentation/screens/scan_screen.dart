import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  Future<void> _captureImage() async {
    try {
      setState(() => _isLoading = true);
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        Navigator.pushNamed(context, '/scan-result', arguments: image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _uploadImage() async {
    try {
      setState(() => _isLoading = true);
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (image != null && mounted) {
        Navigator.pushNamed(context, '/scan-result', arguments: image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection'),
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_florist,
                          size: 80,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Scan Your Plant',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Detect diseases and get treatment recommendations',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Camera Preview Container
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.green.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 60,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Camera Preview',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Capture Button
                  if (!_isLoading)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: _captureImage,
                        icon: const Icon(Icons.camera),
                        label: const Text('Capture from Camera'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 15),
                  // Upload Button
                  if (!_isLoading)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton.icon(
                        onPressed: _uploadImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Upload from Gallery'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green.shade600,
                          side: BorderSide(
                            color: Colors.green.shade600,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  // Tips
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.tips_and_updates,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Tips for Best Results',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTip('Ensure good lighting'),
                        _buildTip('Focus on affected areas'),
                        _buildTip('Take clear, close-up photos'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green.shade600),
          const SizedBox(width: 10),
          Text(tip, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}
