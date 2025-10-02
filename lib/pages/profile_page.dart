import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../cubit/auth_cubit.dart';
import '../models/user_model.dart';
import '../theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _alamatController;
  late TextEditingController _tglLahirController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize controllers dengan data dari state
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _nameController = TextEditingController(text: authState.user.name);
      _usernameController = TextEditingController(text: authState.user.username);
      _alamatController = TextEditingController(text: authState.user.alamat);
      _tglLahirController = TextEditingController(
        text: DateFormat('dd MMMM yyyy').format(authState.user.tglLahir),
      );
      _selectedDate = authState.user.tglLahir;
    } else {
      // Default values jika state tidak tersedia
      _nameController = TextEditingController();
      _usernameController = TextEditingController();
      _alamatController = TextEditingController();
      _tglLahirController = TextEditingController();
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _alamatController.dispose();
    _tglLahirController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.light(primary: kPrimaryColor),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tglLahirController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthSuccess) {
        // Tampilkan dialog konfirmasi
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: 'Simpan Perubahan',
          desc: 'Apakah Anda yakin ingin menyimpan perubahan data profil?',
          btnCancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Batal",
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: bold,
              ),
            ),
          ),
          btnOk: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _performUpdate(authState.user.id);
            },
            child: Text(
              "Simpan",
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: bold,
              ),
            ),
          ),
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: bold,
          ),
          descTextStyle: const TextStyle(
            fontSize: 16,
            color: tGreyColor,
          ),
        ).show();
      }
    }
  }

  void _performUpdate(String userId) {
    // Panggil method update profile dari cubit
    context.read<AuthCubit>().updateProfile(
      userId: userId,
      name: _nameController.text,
      alamat: _alamatController.text,
      tglLahir: _selectedDate,
    );

    // Tampilkan dialog sukses
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Berhasil!',
      desc: 'Data profile berhasil diperbarui.',
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "OK",
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          // Tampilkan error dialog jika update gagal
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Gagal',
            desc: state.error,
            btnOk: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ),
          ).show();
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            final UserModel user = state.user;

            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                title: Text(
                  'Data Pribadi Bunda',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                backgroundColor: kBackgroundColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: kPrimaryColor, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Profile Header dengan Avatar
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  kPrimaryColor.withValues(alpha:0.1),
                                  Color(0xffFBE0EC).withValues(alpha:0.5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withValues(alpha:0.1),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Avatar Circle
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        kPrimaryColor,
                                        kPrimaryColor.withValues(alpha:0.7),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withValues(alpha:0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor.withValues(alpha:0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        user.role.toUpperCase(),
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                    Text(" - ", style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                                    Text(
                                      user.name,
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '@${user.username}',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32),

                          // Section Title
                          _buildSectionTitle('Informasi Pribadi'),
                          SizedBox(height: 20),

                          // Nama Lengkap (EDITABLE)
                          _buildFormField(
                            label: 'Nama Lengkap',
                            controller: _nameController,
                            icon: Icons.person_outline_rounded,
                            editable: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama lengkap harus diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Tanggal Lahir (EDITABLE)
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: _buildFormField(
                                label: 'Tanggal Lahir',
                                controller: _tglLahirController,
                                icon: Icons.calendar_today_rounded,
                                editable: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tanggal lahir harus diisi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          // Alamat (EDITABLE)
                          _buildFormField(
                            label: 'Alamat',
                            controller: _alamatController,
                            icon: Icons.location_on_rounded,
                            maxLines: 3,
                            editable: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Alamat harus diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32),

                          // Section Title untuk Informasi Akun
                          _buildSectionTitle('Informasi Akun'),
                          SizedBox(height: 20),

                          // Username (READONLY)
                          _buildInfoCard(
                            icon: Icons.alternate_email_rounded,
                            title: 'Username',
                            value: user.username,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 12),

                          // Role (READONLY)
                          _buildInfoCard(
                            icon: Icons.verified_user_rounded,
                            title: 'Role',
                            value: user.role,
                            color: Colors.green,
                          ),
                          // SizedBox(height: 12),
                          //
                          // // User ID (READONLY)
                          // _buildInfoCard(
                          //   icon: Icons.fingerprint_rounded,
                          //   title: 'User ID',
                          //   value: user.id,
                          //   color: Colors.purple,
                          // ),
                          SizedBox(height: 32),

                          // Button Simpan
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  kPrimaryColor,
                                  kPrimaryColor.withValues(alpha:0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withValues(alpha:0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: state is AuthLoading ? null : _saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minimumSize: Size(double.infinity, 55),
                              ),
                              child: state is AuthLoading
                                  ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save_rounded, color: Colors.white, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Simpan Perubahan',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AuthLoading) {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: kPrimaryColor),
                    SizedBox(height: 16),
                    Text(
                      'Memuat data...',
                      style: primaryTextStyle,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                title: Text(
                  'Data Pribadi Bunda',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                backgroundColor: kBackgroundColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: kPrimaryColor, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 64,
                        color: tGreyColor,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Data tidak tersedia',
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Silakan coba kembali atau hubungi administrator',
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          'Kembali',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 4,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String? Function(String?) validator,
    bool editable = true,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: tGreyColor.withValues(alpha:0.1),
        ),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        enabled: editable,
        style: primaryTextStyle.copyWith(
          fontSize: 14,
          fontWeight: medium,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: greyTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 12, left: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kPrimaryColor, size: 20),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: !editable ? Icon(Icons.arrow_drop_down_rounded, color: tGreyColor) : null,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: tGreyColor.withValues(alpha:0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.lock_outline_rounded, color: tGreyColor, size: 16),
        ],
      ),
    );
  }
}