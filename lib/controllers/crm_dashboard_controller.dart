import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/crm_dashboard_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrmDashboardController extends MyController {
  String selectRevenue = "Today";
  TooltipBehavior? tooltipBehavior;
  List<CrmDashboardData> crmData = [];

  @override
  void onInit() {
    CrmDashboardData.dummyList.then((value) {
      crmData = value;
      update();
    });
    tooltipBehavior =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    super.onInit();
  }

  void onSelectRevenue(String time) {
    selectRevenue = time;
    update();
  }

  
  }

  
