import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testMergeLeftEnd(){
    List<String> left = Arrays.asList("a", "b");
    List<String> right = Arrays.asList("a", "b", "c");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "b", "c");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testMergeEmpty(){
    List<String> left = Arrays.asList("a", "b");
    List<String> right = Arrays.asList();
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b");
    assertEquals(expected, merged);
  }

  @Test
  public void testFilter(){
    List<String> blah = Arrays.asList("moon", "mOon", "mOON", "MOON", "abel", "computer", "laptop");
    List<String> expectedBlah = Arrays.asList("moon", "mOon", "mOON", "MOON");
    List<String> filtered = ListExamples.filter(blah, new IsMoon());

    assertArrayEquals(expectedBlah.toArray(), filtered.toArray());
  }
}
