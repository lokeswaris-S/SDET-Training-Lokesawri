import java.util.*;

public class Collections {
    public static void main(String[] args) {

        System.out.println("---- ArrayList ----");
        ArrayList<String> names = new ArrayList<>();
        names.add("Loki");
        names.add("Praveen");
        names.add("Hari");
        names.add("Ujitha");
        System.out.println("ArrayList: " + names);
        names.remove("Hari");
        System.out.println("After removal: " + names);
        System.out.println("Contains 'Loki'? " + names.contains("Loki"));
        Collections.sort(names);
        System.out.println("After sorting: " + names);

        System.out.println("\n---- HashMap ----");
        HashMap<Integer, String> students = new HashMap<>();
        students.put(101, "Loki");
        students.put(102, "Ujitha");
        students.put(103, "Hari");
        students.put(104, "Praveen");
        System.out.println("Student HashMap: " + students);
        Set<Map.Entry<Integer, String>> entries = students.entrySet();
        for (Map.Entry<Integer, String> entry : entries) {
            System.out.println("Roll No: " + entry.getKey() + " → Name: " + entry.getValue());
        }
        System.out.println("Traversing only values:");
        for (String name : students.values()) {
            System.out.println(name);
        }
        System.out.println("Traversing only keys:");
        for (Integer rollNo : students.keySet()) {
            System.out.println(rollNo);
        }

        System.out.println("\n---- HashSet ----");
        HashSet<String> fruits = new HashSet<>();
        fruits.add("Apple");
        fruits.add("Mango");
        fruits.add("Banana");
        fruits.add("Orange");
        fruits.add("Apple");
        fruits.add("Orange");
        System.out.println("Fruits Set: " + fruits);
        System.out.println("Contains Mango? " + fruits.contains("Mango"));
        fruits.remove("Banana");
        System.out.println("After removing Banana: " + fruits);
        System.out.println("Traversing using for-each:");
        for (String fruit : fruits) {
            System.out.println(fruit);
        }

        System.out.println("\n---- LinkedList ----");
        Queue<String> queue = new LinkedList<>();
        queue.add("Loki");
        queue.add("Ujitha");
        queue.add("Hari");
        queue.add("Praveen");
        System.out.println("Initial Queue: " + queue);
        System.out.println("Front element (peek): " + queue.peek());
        System.out.println("Removed: " + queue.remove());
        System.out.println("Queue after remove: " + queue);
        queue.add("Sanjana");
        System.out.println("After adding Sanjana: " + queue);
        System.out.println("Polled element: " + queue.poll());
        System.out.println("Queue after poll: " + queue);
        System.out.println("Is queue empty? " + queue.isEmpty());
    }
}
