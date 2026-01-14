import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/locale_cubit.dart';
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
  late TextEditingController _emailController;
  late TextEditingController _alamatController;
  late TextEditingController _tglLahirController;
  late DateTime _selectedDate;

  String _fmtDate(DateTime d, bool isEn) =>
      DateFormat('dd MMMM yyyy', isEn ? 'en_US' : 'id_ID').format(d);

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;

    if (authState is AuthSuccess) {
      _nameController = TextEditingController(text: authState.user.name);
      _emailController = TextEditingController(text: authState.user.email);
      _alamatController = TextEditingController(text: authState.user.alamat);
      _selectedDate = authState.user.tglLahir;

      // isi awal pakai default locale device dulu; nanti akan disesuaikan di build()
      _tglLahirController = TextEditingController(
        text: DateFormat('dd MMMM yyyy').format(authState.user.tglLahir),
      );
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _alamatController = TextEditingController();
      _tglLahirController = TextEditingController();
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _tglLahirController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isEn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      locale: Locale(isEn ? 'en' : 'id', isEn ? 'US' : 'ID'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.light(primary: kPrimaryColor),
            buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tglLahirController.text = _fmtDate(picked, isEn);
      });
    }
  }

  void _saveProfile(bool isEn) {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthSuccess) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: isEn ? 'Save Changes' : 'Simpan Perubahan',
          desc: isEn
              ? 'Are you sure you want to save the changes to your profile?'
              : 'Apakah Anda yakin ingin menyimpan perubahan data profil?',
          btnCancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEn ? "Cancel" : "Batal",
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
              _performUpdate(authState.user.id, isEn);
            },
            child: Text(
              isEn ? "Save" : "Simpan",
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
          descTextStyle: const TextStyle(fontSize: 16, color: tGreyColor),
        ).show();
      }
    }
  }

  void _performUpdate(String userId, bool isEn) {
    context.read<AuthCubit>().updateProfile(
      userId: userId,
      name: _nameController.text,
      alamat: _alamatController.text,
      tglLahir: _selectedDate,
    );

    // NOTE: ini menampilkan sukses langsung (sesuai kode kamu).
    // Kalau mau lebih akurat, sukses sebaiknya ditampilkan saat state update sukses.
    _showSuccessDialog(isEn);
  }

  void _showSuccessDialog(bool isEn) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: isEn ? 'Success!' : 'Berhasil!',
      desc: isEn
          ? 'Your profile has been updated successfully.'
          : 'Data profile berhasil diperbarui.',
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => Navigator.pop(context),
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
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        // sync text tanggal lahir biar ikut bahasa saat switch
        // (tanpa mengubah _selectedDate)
        final newText = _fmtDate(_selectedDate, isEn);
        if (_tglLahirController.text != newText) {
          // hindari setState di build, cukup assign
          _tglLahirController.text = newText;
        }

        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: isEn ? 'Failed' : 'Gagal',
                desc: state.error,
                btnOk: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
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
                      isEn ? 'Personal Data' : 'Data Pribadi Bunda',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    backgroundColor: kBackgroundColor,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    centerTitle: true,
                  ),
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Header
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      kPrimaryColor.withValues(alpha: 0.1),
                                      const Color(0xffFBE0EC)
                                          .withValues(alpha: 0.5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kPrimaryColor.withValues(alpha: 0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
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
                                            kPrimaryColor.withValues(alpha: 0.7),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            kPrimaryColor.withValues(alpha: 0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.person_rounded,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor.withValues(alpha: 0.1),
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
                                        Text(
                                          " - ",
                                          style: blackTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: bold,
                                          ),
                                        ),
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
                                    const SizedBox(height: 4),
                                    Text(
                                      '@${user.email}',
                                      style: greyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),

                              _buildSectionTitle(
                                isEn ? 'Personal Information' : 'Informasi Pribadi',
                              ),
                              const SizedBox(height: 20),

                              _buildFormField(
                                label: isEn ? 'Full Name' : 'Nama Lengkap',
                                controller: _nameController,
                                icon: Icons.person_outline_rounded,
                                editable: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return isEn
                                        ? 'Full name is required'
                                        : 'Nama lengkap harus diisi';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              GestureDetector(
                                onTap: () => _selectDate(context, isEn),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: _buildFormField(
                                    label: isEn ? 'Date of Birth' : 'Tanggal Lahir',
                                    controller: _tglLahirController,
                                    icon: Icons.calendar_today_rounded,
                                    editable: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return isEn
                                            ? 'Date of birth is required'
                                            : 'Tanggal lahir harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              _buildFormField(
                                label: isEn ? 'Address' : 'Alamat',
                                controller: _alamatController,
                                icon: Icons.location_on_rounded,
                                maxLines: 3,
                                editable: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return isEn
                                        ? 'Address is required'
                                        : 'Alamat harus diisi';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              _buildInfoCard(
                                icon: Icons.local_hospital_rounded,
                                title: isEn ? 'Hospital' : 'Rumah Sakit',
                                value: _hospitalLabel(user.hospitalId, isEn),
                                color: Colors.purple,
                              ),
                              const SizedBox(height: 32),

                              _buildSectionTitle(
                                isEn ? 'Account Information' : 'Informasi Akun',
                              ),
                              const SizedBox(height: 20),

                              _buildInfoCard(
                                icon: Icons.alternate_email_rounded,
                                title: isEn ? 'Email' : 'Email',
                                value: user.email,
                                color: Colors.blue,
                              ),
                              const SizedBox(height: 12),

                              _buildInfoCard(
                                icon: Icons.verified_user_rounded,
                                title: isEn ? 'Role' : 'Role',
                                value: user.role,
                                color: Colors.green,
                              ),

                              const SizedBox(height: 32),

                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      kPrimaryColor,
                                      kPrimaryColor.withValues(alpha: 0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kPrimaryColor.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading
                                      ? null
                                      : () => _saveProfile(isEn),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: const Size(double.infinity, 55),
                                  ),
                                  child: state is AuthLoading
                                      ? const SizedBox(
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
                                      const Icon(
                                        Icons.save_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isEn ? 'Save Changes' : 'Simpan Perubahan',
                                        style: whiteTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                        const SizedBox(height: 16),
                        Text(
                          isEn ? 'Loading data...' : 'Memuat data...',
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
                      isEn ? 'Personal Data' : 'Data Pribadi Bunda',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    backgroundColor: kBackgroundColor,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: tGreyColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isEn ? 'Data not available' : 'Data tidak tersedia',
                            style: primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isEn
                                ? 'Please try again or contact the administrator'
                                : 'Silakan coba kembali atau hubungi administrator',
                            style: greyTextStyle.copyWith(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              isEn ? 'Back' : 'Kembali',
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
      },
    );
  }

  // ====== WIDGET HELPERS (tetap) ======

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
        const SizedBox(width: 12),
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: tGreyColor.withValues(alpha: 0.1),
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
            margin: const EdgeInsets.only(right: 12, left: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kPrimaryColor, size: 20),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          suffixIcon:
          !editable ? const Icon(Icons.arrow_drop_down_rounded, color: tGreyColor) : null,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: tGreyColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
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
          const Icon(Icons.lock_outline_rounded, color: tGreyColor, size: 16),
        ],
      ),
    );
  }

  String _hospitalLabel(String hospitalId, bool isEn) {
    switch (hospitalId) {
      case 'rsud_kisa_depok':
        return isEn ? 'RSUD Kisa Depok' : 'RSUD Kisa Depok';
      case 'rsi_sultan_agung':
        return isEn ? 'RSI Sultan Agung' : 'RSI Sultan Agung';
      default:
        return isEn ? 'Unknown Hospital' : 'RS tidak diketahui';
    }
  }
}
