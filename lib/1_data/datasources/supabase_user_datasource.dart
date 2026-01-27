import 'package:loans/1_data/datasources/user_datasource.dart';
import 'package:loans/1_data/models/company_model.dart';
import 'package:loans/1_data/models/user_model.dart';
import 'package:loans/3_utils/errors/exceptions.dart' as app_exceptions;
import 'package:supabase_flutter/supabase_flutter.dart';

typedef UserOperation<T> = Future<T> Function();

class SupabaseUserDataSource implements UserDataSource {
  SupabaseUserDataSource({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<T> _handleUserErrors<T>(UserOperation<T> operation) async {
    try {
      return await operation();
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      throw app_exceptions.DatabaseException(message: message);
    }
  }

  @override
  Future<UserModel> createUserOnboarding(UserModel user) {
    return _handleUserErrors(() async {
      final data = await supabaseClient
          .from('users')
          .insert(user.toJson())
          .select()
          .single();

      return UserModel.fromJson(data);
    });
  }

  @override
  Future<bool> isRootIdAvailable(String rootId) {
    return _handleUserErrors(() async {
      final response = await supabaseClient
          .from('users')
          .select('id')
          .eq('root_id', rootId)
          .maybeSingle();

      return response == null;
    });
  }

  @override
  Future<CompanyModel> createCompany(CompanyModel company) {
    return _handleUserErrors(() async {
      final data = await supabaseClient
          .from('companies')
          .insert(company.toJson())
          .select()
          .single();

      return CompanyModel.fromJson(data);
    });
  }

  @override
  Future<CompanyModel> getCompanyByName(String name) {
    return _handleUserErrors(() async {
      final data = await supabaseClient
          .from('companies')
          .select()
          .eq('name', name)
          .single();

      return CompanyModel.fromJson(data);
    });
  }

  @override
  Future<void> joinCompany(String companyId) {
    return _handleUserErrors(() async {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('No authenticated user');
      }

      await supabaseClient
          .from('users')
          .update({'company_id': companyId}).eq('id', userId);
    });
  }

  @override
  Future<UserModel> getUserById(String userId) {
    return _handleUserErrors(() async {
      final data =
          await supabaseClient.from('users').select().eq('id', userId).single();

      return UserModel.fromJson(data);
    });
  }
}
