import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxBool isLoginActive = false.obs;
  final RxBool isSignupActive = true.obs;

  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Listen to text changes to enable/disable login button
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle between login and signup tabs
  void toggleTab(bool isLogin) {
    isLoginActive.value = isLogin;
    isSignupActive.value = !isLogin;
    clearErrors();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Validate form and enable/disable login button
  void _validateForm() {
    email.value = emailController.text;
    password.value = passwordController.text;
    
    // Enable login button if both fields have content and email is valid
    // bool isValid = email.value.isNotEmpty && 
    //                password.value.isNotEmpty && 
    //                _isValidEmail(email.value);
    
    // Update button state (you can add this to your UI)
    // isLoginButtonEnabled.value = isValid;
  }

  // Clear all error messages
  void clearErrors() {
    emailError.value = '';
    passwordError.value = '';
  }

  // Validate email field
  void validateEmail() {
    if (email.value.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!_isValidEmail(email.value)) {
      emailError.value = 'Please enter a valid email';
    } else {
      emailError.value = '';
    }
  }

  // Validate password field
  void validatePassword() {
    if (password.value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (password.value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = '';
    }
  }

  // Login method
  Future<void> login() async {
    // Clear previous errors
    clearErrors();
    
    // Validate fields
    validateEmail();
    validatePassword();
    
    // Check if there are any errors
    if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
      return;
    }
    
    // Set loading state
    isLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Replace with actual API call
      // final response = await AuthService.login(email.value, password.value);
      
      // For now, just show success message
      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF00E676),
        colorText: Colors.white,
      );
      
      // TODO: Navigate to main app or dashboard
      // Get.offAllNamed('/dashboard');
      
    } catch (e) {
      // Handle login error
      Get.snackbar(
        'Error',
        'Login failed. Please check your credentials.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Signup method
  Future<void> signup() async {
    // Clear previous errors
    clearErrors();
    
    // Validate fields
    validateEmail();
    validatePassword();
    
    // Check if there are any errors
    if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
      return;
    }
    
    // Set loading state
    isLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Replace with actual API call
      // final response = await AuthService.signup(email.value, password.value);
      
      // For now, just show success message
      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF00E676),
        colorText: Colors.white,
      );
      
    } catch (e) {
      // Handle signup error
      Get.snackbar(
        'Error',
        'Signup failed. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
