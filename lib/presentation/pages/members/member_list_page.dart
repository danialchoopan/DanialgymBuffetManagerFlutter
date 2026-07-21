import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../blocs/member/member_bloc.dart';
import '../../widgets/members/member_card.dart';
import '../../widgets/common/loading_overlay.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    context.read<MemberBloc>().add(const LoadMembers());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _navigateToAddMember,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search members...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MemberBloc>().add(const LoadMembers());
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.grey100,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<MemberBloc>().add(SearchMembers(query: value));
                } else {
                  context.read<MemberBloc>().add(const LoadMembers());
                }
              },
            ),
          ),

          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Active', 'active'),
                const SizedBox(width: 8),
                _buildFilterChip('Expired', 'expired'),
                const SizedBox(width: 8),
                _buildFilterChip('Suspended', 'suspended'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Member List
          Expanded(
            child: BlocBuilder<MemberBloc, MemberState>(
              builder: (context, state) {
                if (state is MemberLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is MemberError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: AppTypography.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MemberBloc>().add(const LoadMembers());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is MembersLoaded) {
                  if (state.members.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.people_outline,
                            size: 64,
                            color: AppColors.grey400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No members found',
                            style: AppTypography.headlineSmall.copyWith(
                              color: AppColors.grey600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first member to get started',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.grey500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _navigateToAddMember,
                            icon: const Icon(Icons.person_add),
                            label: const Text('Add Member'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.members.length,
                    itemBuilder: (context, index) {
                      final member = state.members[index];
                      return MemberCard(
                        name: '${member.firstName} ${member.lastName}',
                        membershipType: member.membershipType,
                        membershipStatus: member.membershipStatus,
                        photoPath: member.photoPath,
                        membershipEndDate: member.membershipEndDate,
                        onTap: () => _navigateToMemberDetail(member.id),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddMember,
        backgroundColor: AppColors.primaryLight,
        child: const Icon(Icons.person_add, color: AppColors.white),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
        if (value == 'all') {
          context.read<MemberBloc>().add(const LoadMembers());
        } else {
          context.read<MemberBloc>().add(FilterMembersByStatus(status: value));
        }
      },
      selectedColor: AppColors.primaryLight,
      checkmarkColor: AppColors.white,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.white : AppColors.grey700,
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Members',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('All Members'),
                trailing: _selectedFilter == 'all'
                    ? const Icon(Icons.check, color: AppColors.primaryLight)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedFilter = 'all';
                  });
                  context.read<MemberBloc>().add(const LoadMembers());
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle, color: AppColors.success),
                title: const Text('Active Members'),
                trailing: _selectedFilter == 'active'
                    ? const Icon(Icons.check, color: AppColors.primaryLight)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedFilter = 'active';
                  });
                  context
                      .read<MemberBloc>()
                      .add(const FilterMembersByStatus(status: 'active'));
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: AppColors.error),
                title: const Text('Expired Members'),
                trailing: _selectedFilter == 'expired'
                    ? const Icon(Icons.check, color: AppColors.primaryLight)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedFilter = 'expired';
                  });
                  context
                      .read<MemberBloc>()
                      .add(const FilterMembersByStatus(status: 'expired'));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.pause_circle, color: AppColors.warning),
                title: const Text('Suspended Members'),
                trailing: _selectedFilter == 'suspended'
                    ? const Icon(Icons.check, color: AppColors.primaryLight)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedFilter = 'suspended';
                  });
                  context
                      .read<MemberBloc>()
                      .add(const FilterMembersByStatus(status: 'suspended'));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToAddMember() {
    Navigator.pushNamed(context, '/members/add');
  }

  void _navigateToMemberDetail(String memberId) {
    Navigator.pushNamed(context, '/members/$memberId');
  }
}