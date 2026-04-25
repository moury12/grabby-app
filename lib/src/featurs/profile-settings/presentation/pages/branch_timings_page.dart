import 'package:grabby_app/src/featurs/profile-settings/data/models/branch_model.dart';
import 'package:grabby_app/src/featurs/profile-settings/presentation/bloc/branch/branch_bloc.dart';
import '../../../../src_export.dart';

class BranchTimingsPage extends StatefulWidget {
  const BranchTimingsPage({super.key});

  @override
  State<BranchTimingsPage> createState() => _BranchTimingsPageState();
}

class _BranchTimingsPageState extends State<BranchTimingsPage> {
  ShopBranchModel? _selectedBranch;

  final Map<String, Map<String, dynamic>> _timings = {
    "Monday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Tuesday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Wednesday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Thursday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Friday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Saturday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
    "Sunday": {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"},
  };

  void _updateTimingsFromBranch(ShopBranchModel branch) {
    if (branch.availability.isNotEmpty) {
      for (var a in branch.availability) {
        if (_timings.containsKey(a.day)) {
          _timings[a.day] = {
            "isOpen": !a.isClosed,
            "open": a.open,
            "close": a.close,
          };
        }
      }
    } else {
      // reset to default if empty
      _timings.forEach((key, value) {
        _timings[key] = {"isOpen": true, "open": "8:00 AM", "close": "10:00 PM"};
      });
    }
  }

  Future<void> _selectTime(String day, bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final timeStr = picked.format(context);
        if (isOpening) {
          _timings[day]!["open"] = timeStr;
        } else {
          _timings[day]!["close"] = timeStr;
        }
      });
    }
  }

  void _saveTimings() {
    if (_selectedBranch == null) return;
    List<Map<String, dynamic>> availability = [];
    _timings.forEach((day, data) {
      availability.add({
        "day": day,
        "open": data["open"],
        "close": data["close"],
        "isClosed": !(data["isOpen"] as bool),
      });
    });
    context.read<BranchBloc>().add(UpdateBranchAvailabilityEvent(_selectedBranch!.id, availability));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BranchBloc, BranchState>(
      listener: (context, state) {
        if (state is BranchOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is BranchError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
        } else if (state is BranchDetailsLoaded) {
          setState(() {
            _selectedBranch = state.branch;
            _updateTimingsFromBranch(state.branch);
          });
        }
      },
      buildWhen: (previous, current) =>
          current is BranchesLoaded ||
          current is BranchLoading ||
          current is BranchInitial ||
          current is BranchDetailsLoaded,
      builder: (context, state) {
        List<ShopBranchModel> branches = [];
        if (state is BranchesLoaded) {
          branches = state.branches;
          if (branches.isNotEmpty) {
            if (_selectedBranch == null) {
              _selectedBranch = branches.first;
              _updateTimingsFromBranch(_selectedBranch!);
            } else {
              // Update selected branch reference from new list to get latest data
              final updatedBranch = branches.firstWhere(
                (b) => b.id == _selectedBranch!.id,
                orElse: () => branches.first,
              );
              _selectedBranch = updatedBranch;
              _updateTimingsFromBranch(_selectedBranch!);
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: CustomText(
              AppStaticStrings.perBranch,
              variant: TextVariant.titleLarge,
            ),
            actions: [_buildBranchDropdown(branches)],
          ),
          body: (state is BranchLoading && branches.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<BranchBloc>().add(GetBranchesEvent());
                    if (_selectedBranch != null) {
                      context
                          .read<BranchBloc>()
                          .add(GetBranchDetailsEvent(_selectedBranch!.id));
                    }
                  },
                  child: SingleChildScrollView(
                    padding: AppPadding.getPadding12H(context),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._timings.entries.map((entry) {
                          return TimingRow(
                            day: entry.key,
                            isOpen: entry.value["isOpen"],
                            openingTime: entry.value["open"],
                            closingTime: entry.value["close"],
                            onOpeningTimeTap: () => _selectTime(entry.key, true),
                            onClosingTimeTap: () =>
                                _selectTime(entry.key, false),
                            onToggle: (val) {
                              setState(() {
                                _timings[entry.key]!["isOpen"] = val;
                              });
                            },
                          );
                        }),
                        _buildHoursSummaryBox(context),
                        _buildImportantNotes(context),
                        space2H,
                        CustomButton(
                          text: "Save Timings",
                          onPressed:
                              _selectedBranch != null ? _saveTimings : () {},
                        ),
                        space4H,
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBranchDropdown(List<ShopBranchModel> branches) {
    if (branches.isEmpty) return const SizedBox();
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ShopBranchModel>(
          value: _selectedBranch,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.kPrimaryColor),
          style: const TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12),
          onChanged: (val) {
            if (val != null) {
              context.read<BranchBloc>().add(GetBranchDetailsEvent(val.id));
            }
          },
          items: branches.map((b) => DropdownMenuItem(value: b, child: Text(b.branchName.isNotEmpty ? b.branchName : "Unnamed Branch"))).toList(),
        ),
      ),
    );
  }

  Widget _buildHoursSummaryBox(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            AppStaticStrings.hoursSummary,
            variant: TextVariant.titleSmall,
            fontWeight: FontWeight.bold,
          ),

          _buildHoursSummaryTable(),
        ],
      ),
    );
  }

  Widget _buildHoursSummaryTable() {
    final summary = _timings.entries.map((entry) {
      return [entry.key, "${entry.value["open"]} - ${entry.value["close"]}"];
    }).toList();

    return Column(
      children: summary
          .map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    row[0],
                    variant: TextVariant.labelSmall,
                    color: AppColors.kSecondaryTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    row[1],
                    variant: TextVariant.labelSmall,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildImportantNotes(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: const Color(0xffEFF6FF), // Light blue background
        borderRadius: BorderRadius.circular(appRadius16),
        border: Border.all(color: const Color(0xffBFDBFE)), // Blue border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: Color(0xff2563EB), // Blue icon
              ),

              CustomText(
                AppStaticStrings.importantNotes,
                variant: TextVariant.titleSmall,
                color: Color(0xff1E40AF), // Dark blue text
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          _buildNoteItem(AppStaticStrings.hoursChangesEffect),
          _buildNoteItem(AppStaticStrings.customersSeeUpdatedHours),
          _buildNoteItem(AppStaticStrings.specialHolidayHours),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "• ",
            variant: TextVariant.labelSmall,
            color: Color(0xff2563EB),
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: CustomText(
              text,
              variant: TextVariant.labelSmall,
              color: const Color(0xff1E40AF).withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
