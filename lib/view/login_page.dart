import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00E676), // Bright green
              Color(0xFF00BCD4), // Teal/cyan
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with tabs
              _buildTopSection(controller),
              
              // Middle section with login form
              Expanded(
                child: _buildLoginForm(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          // Login Tab
          GestureDetector(
            onTap: () => controller.toggleTab(true),
            child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: controller.isLoginActive.value 
                        ? Colors.white 
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: controller.isLoginActive.value 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            )),
          ),
          
          const SizedBox(width: 24),
          
          // Sign up Tab
          GestureDetector(
            onTap: () => controller.toggleTab(false),
            child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: controller.isSignupActive.value 
                        ? Colors.white 
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: controller.isSignupActive.value 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(LoginController controller) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Email Input Field
            _buildEmailField(controller),
            
            const SizedBox(height: 20),
            
            // Password Input Field
            _buildPasswordField(controller),
            
            const SizedBox(height: 16),
            
            // Instruction Text
            Obx(() => Text(
              controller.isLoginActive.value 
                  ? 'Log in with your email and password'
                  : 'Sign up with your email and password',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )),
            
            const SizedBox(height: 32),
            
            // Login/Signup Button
            _buildActionButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFF673AB7),
            ),
            suffixIcon: Obx(() => controller.email.value.isNotEmpty && 
                controller.emailError.value.isEmpty
                ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF00E676),
                  )
                : const SizedBox.shrink()),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF673AB7)),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          onChanged: (value) {
            controller.email.value = value;
            if (controller.emailError.value.isNotEmpty) {
              controller.validateEmail();
            }
          },
          onSubmitted: (_) => controller.validateEmail(),
        ),
        Obx(() => controller.emailError.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  controller.emailError.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF673AB7),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => controller.password.value.isNotEmpty && 
                    controller.passwordError.value.isEmpty
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF00E676),
                      )
                    : const SizedBox.shrink()),
                const SizedBox(width: 8),
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: controller.togglePasswordVisibility,
                )),
              ],
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF673AB7)),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          onChanged: (value) {
            controller.password.value = value;
            if (controller.passwordError.value.isNotEmpty) {
              controller.validatePassword();
            }
          },
          onSubmitted: (_) => controller.validatePassword(),
        )),
        Obx(() => controller.passwordError.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  controller.passwordError.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildActionButton(LoginController controller) {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isLoading.value 
            ? null 
            : (controller.isLoginActive.value 
                ? controller.login 
                : controller.signup),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF00E676), // Bright green
                Color(0xFF00BCD4), // Teal/cyan
              ],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    controller.isLoginActive.value ? 'Log in' : 'Sign up',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    ));
  }
}
