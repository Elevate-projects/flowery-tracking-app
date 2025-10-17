 sealed class BottomNavigationIntent{}
 class OnBottomTabsClick extends BottomNavigationIntent{
   final int index;
   OnBottomTabsClick({required this.index});
 }
 class OnPageSwiped extends BottomNavigationIntent {
   final int index;
   OnPageSwiped({required this.index});
 }
