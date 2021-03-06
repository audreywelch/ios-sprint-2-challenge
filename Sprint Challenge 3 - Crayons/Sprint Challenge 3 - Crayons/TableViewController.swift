import UIKit

class TableViewController: UITableViewController {
    
    var crayon: Crayon?
    
    
    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Number of sections = number of alphabet letters used - received from model
        return CrayonHelper.shared.sectionCount
    
    }
    
    
    // Number of Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows = number of colors in model
        return CrayonHelper.shared.rowCountFor(section: section)
    }
    
    
    // Cell for Row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cast the cell as a TableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else { fatalError("Unable to dequeue proper cell") }
        
        // Customize the cell
        // Add the text to the label
        cell.nameLabel.text = CrayonHelper.shared.colorNameFor(indexPath: indexPath) // sectionNameFor(indexPath: indexPath)
        
        // Add the color to the leading panel view
        cell.colorPanelLeading.backgroundColor = CrayonHelper.shared.colorFor(indexPath: indexPath)
        
        // Add the color to the trailing panel view
        cell.colorPanelTrailing.backgroundColor = CrayonHelper.shared.colorFor(indexPath: indexPath)
        
        // Add the image to the view
        cell.crayonImage.image = CrayonHelper.shared.crayonFor(indexPath: indexPath).image
        
        return cell
    }
    
    
    // Set up the header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Create a label
        let label = UILabel()
        
        // Set label's text features
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        
        // Set text to section name by passing it an index path
        label.text = CrayonHelper.shared.sectionNameFor(indexPath: IndexPath(row: 0, section: section))
        
        // return the label
        return label
        
    }
    
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get index path
        // Get view controller
        guard
            let destination = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
            else { return }
        
        let crayon = CrayonHelper.shared.crayonFor(indexPath: indexPath)
        destination.crayon = crayon
        
    }
    
}
